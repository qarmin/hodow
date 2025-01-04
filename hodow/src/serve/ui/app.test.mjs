import test from 'node:test';
import assert from 'node:assert/strict';
import { createRequire } from 'node:module';

const ui = createRequire(import.meta.url)('./app.js');

const step = (over) => ({ id: 1, parent: null, depth: 0, label: 'CPU tests', unit: 'tests', done: 0, total: null, current: null,
  state: 'running', fraction: null, rate: null, eta_secs: null, elapsed_ms: 0, ...over });
const summary = (over) => ({ total: 0, passed: 0, unverified: 0, skipped: 0, not_supported: 0, failed: 0, panicked: 0, timed_out: 0, crashed: 0, ...over });
const run = (over) => ({ module: 'cpu', title: 'CPU tests', status: 'running', elapsed_ms: 65000, summary: summary({ total: 10, passed: 9, failed: 1 }),
  steps: [step({ fraction: 0.4, done: 4, total: 10 })], notable: [], notable_dropped: 0, logs: [], ...over });

test('everything that comes from a test is escaped', () => {
  const evil = '<img src=x onerror=alert(1)>';
  const html = ui.runHtml(run({
    title: evil,
    notable: [{ name: evil, verdict: 'failed', detail: evil }, { name: 'ok', verdict: 'unverified', value: evil }],
    logs: [['info', evil]],
    steps: [step({ label: evil, current: evil, fraction: 0.5, done: 5, total: 10 })],
  }));
  assert.ok(!html.includes('<img'), html);
  assert.ok(html.includes('&lt;img'));
  assert.equal(ui.esc(`"'&`), '&quot;&#39;&amp;');
});

test('durations and ids read naturally', () => {
  assert.equal(ui.fmtDur(0), '0s');
  assert.equal(ui.fmtDur(61000), '1m01s');
  assert.equal(ui.fmtDur(3723000), '1h02m');
  assert.equal(ui.whenOfId('20261109-213944-cpu-2'), '2026-11-09 21:39:44');
});

test('a counted step shows a percentage and a left-over time, an unknown total animates', () => {
  const counted = ui.stepsHtml([step({ fraction: 0.42, done: 42, total: 100, eta_secs: 90 })]);
  assert.match(counted, /42\/100 tests/);
  assert.match(counted, /42%/);
  assert.match(counted, /~1m30s left/);
  assert.doesNotMatch(counted, /indeterminate/);
  const unknown = ui.stepsHtml([step({ done: 302 })]);
  assert.match(unknown, /indeterminate/);
  assert.match(unknown, /302 tests/);
  assert.doesNotMatch(unknown.replace(/<[^>]*>/g, ''), /%/);
});

test('a step measured in seconds says how long is left without guessing from a rate', () => {
  const html = ui.stepsHtml([step({ unit: 's', done: 3, total: 60, fraction: 0.05, eta_secs: 79 })]);
  assert.match(html, /57s left/);
  assert.doesNotMatch(html, /79/);
});

test('hundreds of finished families collapse into the roots, what runs and the latest few', () => {
  const steps = [step({ id: 1, fraction: 0.5, done: 150, total: 300 })];
  for (let i = 2; i <= 300; i++) steps.push(step({ id: i, depth: 1, label: `fam${i}`, state: 'done', fraction: 1 }));
  steps.push(step({ id: 301, depth: 1, label: 'running-one', fraction: 0.2, done: 2, total: 10 }));
  const { shown, hidden } = ui.visibleSteps(steps);
  assert.deepEqual(shown.map((s) => s.label), ['CPU tests', 'fam298', 'fam299', 'fam300', 'running-one']);
  assert.equal(hidden, 296);
  assert.match(ui.stepsHtml(steps), /296 finished step\(s\) not shown/);
});

test('counts leave out what is zero, except the total', () => {
  const html = ui.countChips(summary({ total: 5, passed: 4, failed: 1 }));
  assert.match(html, /5 tests/);
  assert.match(html, /4 passed/);
  assert.match(html, /1 failed/);
  assert.doesNotMatch(html, /unverified|skipped|crashed/);
  assert.equal(ui.countChips(null), '');
});

test('a check that cannot run here has its button disabled and says why', () => {
  const modules = [
    { key: 'cpu', title: 'CPU', about: 'a', availability: { state: 'ok', detail: 'x', devices: [] }, last_run: null, running: false },
    { key: 'vulkan', title: 'Vulkan', about: 'b', availability: { state: 'unavailable', detail: 'loader not available', devices: [] }, last_run: null, running: false },
    { key: 'gl', title: 'GL', about: 'c', availability: { state: 'ok', detail: '', devices: ['llvmpipe'] },
      last_run: { id: '20261109-120000-gl', status: 'failed', summary: summary({ total: 3, failed: 1 }), started_ms: 0, finished_ms: 5000 }, running: true },
  ];
  const html = ui.modulesHtml({ modules });
  assert.match(html, /not available here/);
  assert.match(html, /loader not available/);
  assert.match(html, /disabled/);
  assert.match(html, /llvmpipe/);
  assert.match(html, /2026-11-09 12:00:00 in 5s/);
  assert.match(html, /card running/);
  assert.equal((html.match(/data-module="/g) || []).length, 3);
});

test('the runs table and the empty states', () => {
  assert.match(ui.runsHtml({ runs: [] }), /No runs kept yet/);
  const html = ui.runsHtml({ runs: [{ id: '20261109-213944-vulkan', module: 'vulkan', status: 'succeeded', started_ms: 0, finished_ms: 300, summary: summary({ total: 2, passed: 2 }) }] });
  assert.match(html, /2026-11-09 21:39:44/);
  assert.match(html, /passed/);
  assert.match(ui.liveHtml({ active: null, foreign: [] }), /Nothing is running/);
  assert.equal(ui.queueHtml({ queue: [] }), '');
});

test('a run started from a terminal is labelled, and only a queued job can be stopped', () => {
  const foreign = ui.liveHtml({ active: null, foreign: [{ id: '20261109-1-cpu', run: run() }] });
  assert.match(foreign, /started from a terminal/);
  assert.doesNotMatch(foreign, /cancel-job/);
  const ours = ui.liveHtml({ active: { job: { id: 7, run: '20261109-2-cpu' }, run: run() }, foreign: [] });
  assert.match(ours, /data-action="cancel-job" data-id="7"/);
});

test('arguments are built from the choices and the free text, and the server is trusted to refuse the rest', () => {
  const cpu = ui.START.cpu;
  assert.deepEqual(ui.buildArgs(cpu, { preset: 0, flags: [true], extra: ' -t  test_x ' }), ['test', 'cpu', '--isolate', '--flows', '-t', 'test_x']);
  assert.deepEqual(ui.buildArgs(cpu, { preset: 1, flags: [false] }), ['test', 'cpu']);
  assert.deepEqual(ui.buildArgs(ui.START.stress, { number: 30 }), ['cpu', '--stress', '--stress-secs', '30']);
  assert.deepEqual(ui.buildArgs(ui.START.burn, { preset: 0, text: '90s' }), ['burn', '--duration', '90s']);
  assert.deepEqual(ui.buildArgs(ui.START.burn, { preset: 1, text: '90s' }), ['burn', '--quick']);
  assert.deepEqual(ui.buildArgs(ui.START['gpu-memtest'], { number: 128 }), ['gpu', '--memtest', '--memtest-mb', '128']);
  assert.deepEqual(ui.buildArgs(ui.START.bench, { preset: 2 }), ['bench', '--full']);
  assert.deepEqual(ui.buildArgs(ui.START.cts, { preset: 2, extra: '-j 2' }), ['cts', '--case', 'dEQP-GLES31.*', '-j', '2']);
  assert.deepEqual(ui.buildArgs(ui.START.cts, { preset: 5, extra: '--case dEQP-VK.compute.*' }), ['cts', '--case', 'dEQP-VK.compute.*']);
});

test('the detail view pages and can be filtered', () => {
  const detail = { meta: { id: '20261109-1-cpu', title: 'CPU', status: 'failed', os: 'linux', arch: 'x86_64', version: '0.1.0', args: ['test', 'cpu'],
    started_ms: 0, finished_ms: 2000, summary: summary({ total: 3, failed: 1 }) }, pinned: true, files: ['report.html'] };
  const view = { verdict: 'failed', q: 'a"b', offset: 0, limit: 100,
    findings: { total: 250, offset: 0, items: [{ name: 'test_a', verdict: 'failed', detail: 'got 1' }] } };
  const html = ui.detailHtml(detail, view);
  assert.match(html, /1–1 of 250/);
  assert.match(html, /value="a&quot;b"/);
  assert.match(html, /<option value="failed" selected>/);
  assert.match(html, /Unpin/);
  assert.match(html, /report\.html/);
  assert.match(html, /data-dir="-1" disabled/);
  assert.doesNotMatch(html, /data-dir="1" disabled/);
});

import fs from 'node:fs';
import vm from 'node:vm';

test('every element the script looks up by id exists in the page', () => {
  const js = fs.readFileSync(new URL('./app.js', import.meta.url), 'utf8');
  const html = fs.readFileSync(new URL('./index.html', import.meta.url), 'utf8');
  const used = new Set([...js.matchAll(/\$\('([^']+)'\)/g)].map((m) => m[1]));
  const defined = new Set([...html.matchAll(/\bid="([^"]+)"/g)].map((m) => m[1]));
  const created = new Set(['start-number', 'start-text', 'f-verdict', 'f-q']);
  const missing = [...used].filter((id) => !defined.has(id) && !created.has(id));
  assert.deepEqual(missing, []);
});

test('the page wires itself up, paints a pushed state and survives a reconnect', async () => {
  const elements = new Map();
  const element = (id) => {
    if (!elements.has(id)) {
      elements.set(id, { id, dataset: {}, innerHTML: '', textContent: '', className: '', hidden: false, value: '', open: false,
        addEventListener() {}, showModal() { this.open = true; }, close() { this.open = false; } });
    }
    return elements.get(id);
  };
  const sockets = [];
  class FakeSocket { constructor(url) { this.url = url; sockets.push(this); } }
  const timers = [];
  const context = vm.createContext({
    document: { getElementById: element, addEventListener() {}, querySelector() { return null; }, querySelectorAll() { return []; }, activeElement: null },
    location: { protocol: 'http:', host: 'box:7878' },
    WebSocket: FakeSocket, fetch: async () => ({ ok: true, json: async () => ({}) }), setTimeout: (f, ms) => timers.push([f, ms]),
    clearTimeout() {}, console, alert() {}, confirm: () => true,
  });
  vm.runInContext(fs.readFileSync(new URL('./help.js', import.meta.url), 'utf8'), context);
  vm.runInContext(fs.readFileSync(new URL('./app.js', import.meta.url), 'utf8'), context);
  assert.equal(sockets.length, 1);
  assert.equal(sockets[0].url, 'ws://box:7878/ws');

  sockets[0].onopen();
  assert.equal(element('conn').textContent, 'live');
  const state = { host: 'hodow 0.1.0 | Linux', data_dir: '/data', version: '0.1.0', now: 1, queue: [], foreign: [], recent_jobs: [], runs: [],
    modules: [{ key: 'cpu', title: 'CPU', about: 'a', availability: { state: 'ok', detail: '', devices: [] }, last_run: null, running: false }],
    active: { job: { id: 1, module: 'cpu', run: null }, run: run() } };
  sockets[0].onmessage({ data: JSON.stringify(state) });
  assert.equal(element('host').textContent, 'hodow 0.1.0 | Linux');
  assert.match(element('modules').innerHTML, /CPU/);
  assert.match(element('live').innerHTML, /cancel-job/);
  assert.match(element('runs').innerHTML, /No runs kept yet/);
  assert.equal(element('queue-section').hidden, true);

  sockets[0].onclose();
  assert.equal(element('conn').className, 'pill down');
  assert.equal(timers.at(-1)[1], 2000, 'a reconnect is scheduled');
});

/* ---------- help ---------- */

const HELP = createRequire(import.meta.url)('./help.js');
const topicsIn = (html) => [...html.matchAll(/data-topic="([^"]+)"/g)].map((m) => m[1]);

test('every topic has what the page needs, and only points at topics that exist', () => {
  for (const [key, t] of Object.entries(HELP)) {
    assert.ok(t.title && t.short && t.body && t.group, `${key} is incomplete`);
    for (const r of t.related ?? []) assert.ok(HELP[r], `${key} points at missing ${r}`);
    assert.ok(!/<script|onerror|onclick/i.test(t.body), `${key} must not carry script`);
  }
});

test('every verdict, status and check has an explanation', () => {
  for (const v of ['passed', 'unverified', 'skipped', 'not_supported', 'failed', 'panicked', 'timed_out', 'crashed', 'total']) {
    assert.ok(HELP[`verdict-${v}`], `verdict ${v}`);
  }
  for (const st of ['running', 'succeeded', 'failed', 'crashed', 'interrupted', 'cancelled', 'skipped']) assert.ok(HELP[`status-${st}`], `status ${st}`);
  for (const key of Object.keys(ui.START)) assert.ok(HELP[`module-${key}`], `check ${key}`);
});

test('what the page renders only points at topics that exist', () => {
  const state = { queue: [], recent_jobs: [], runs: [{ id: '20261109-1-cpu', module: 'cpu', status: 'interrupted', started_ms: 0, finished_ms: 9, summary: summary({ total: 9, passed: 3, unverified: 2, skipped: 1, not_supported: 1, failed: 1, panicked: 1, timed_out: 1, crashed: 1 }) }],
    modules: Object.keys(ui.START).map((key) => ({ key, title: key, about: 'x', availability: { state: 'ok', detail: '', devices: [] }, last_run: null, running: false })),
    active: { job: { id: 1, run: null }, run: run({ notable: [{ name: 'a', verdict: 'unverified', value: '1' }, { name: 'b', verdict: 'timed_out' }] }) },
    foreign: [{ id: 'x', run: run() }] };
  const html = [ui.modulesHtml(state), ui.liveHtml(state), ui.runsHtml(state)].join('');
  const used = new Set(topicsIn(html));
  assert.ok(used.size > 15, `only ${used.size} topics were used`);
  for (const topic of used) assert.ok(HELP[topic], `rendered a button for missing topic ${topic}`);
  const page = fs.readFileSync(new URL('./index.html', import.meta.url), 'utf8');
  for (const topic of topicsIn(page)) assert.ok(topic === 'index' || HELP[topic], `index.html asks for ${topic}`);
});

test('labels and buttons explain themselves, and an unknown status stays a plain label', () => {
  assert.match(ui.countChips(summary({ total: 2, unverified: 2 })), /data-topic="verdict-unverified"[^>]*title="Ran without crashing/);
  assert.match(ui.statusChip('crashed'), /data-topic="status-crashed"/);
  assert.doesNotMatch(ui.statusChip('mystery'), /data-action/);
  assert.match(ui.helpBtn('queue', 'the queue'), /aria-label="Explain the queue"/);
  assert.match(ui.verdictLabel('not_supported'), /not supported/);
});

test('the help window shows a topic with its related ones, lists every topic, and survives a missing one', () => {
  const html = ui.helpHtml('verdict-unverified');
  assert.match(html, /<h3>Unverified<\/h3>/);
  assert.match(html, /nothing to compare/);
  assert.match(html, /See also:[\s\S]*data-topic="verdict-passed"/);
  const index = ui.helpHtml('index');
  for (const [key, t] of Object.entries(HELP)) assert.ok(index.includes(`data-topic="${key}"`), `${key} missing from the list`);
  assert.match(index, /<h4>Reading results<\/h4>/);
  assert.match(ui.helpHtml('no-such-topic'), /No explanation/);
  assert.ok(!ui.helpHtml('<img src=x>').includes('<img'));
});

test('a dialog never hides its close button: the body scrolls, the footer and the cross stay', () => {
  const page = fs.readFileSync(new URL('./index.html', import.meta.url), 'utf8');
  const dialogs = page.split('<dialog').slice(1).map((d) => d.split('</dialog>')[0]);
  assert.equal(dialogs.length, 3);
  for (const d of dialogs) {
    assert.match(d, /class="dlg-x"/, 'a close cross');
    assert.match(d, /class="dlg-body[^"]*"/, 'a scrolling body');
    const foot = d.split('dlg-foot')[1] ?? '';
    assert.match(foot, />(Close|Cancel)</, 'a close button in the footer');
    assert.ok(d.indexOf('dlg-body') < d.indexOf('dlg-foot'), 'the footer comes after the body');
  }
  const css = fs.readFileSync(new URL('./style.css', import.meta.url), 'utf8');
  assert.match(css, /dialog\[open\] \{[^}]*display: flex[^}]*max-height: 90vh/);
  assert.match(css, /\.dlg-body \{[^}]*overflow: auto/);
  assert.match(css, /\.dlg-foot \{[^}]*flex: none/);
  for (const rule of css.matchAll(/(^|\n)(dialog[^{]*)\{([^}]*)\}/g)) {
    assert.doesNotMatch(rule[3], /overflow\s*:\s*(auto|scroll)/, `${rule[2].trim()} must not scroll itself`);
  }
});
