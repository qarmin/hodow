'use strict';

/* ---------- formatting (pure) ---------- */

const TOPICS = typeof require === 'function' ? require('./help.js') : HELP;

const esc = (value) =>
  String(value ?? '').replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]);

function fmtDur(ms) {
  const s = Math.max(0, Math.round(ms / 1000));
  if (s < 60) return `${s}s`;
  if (s < 3600) return `${Math.floor(s / 60)}m${String(s % 60).padStart(2, '0')}s`;
  return `${Math.floor(s / 3600)}h${String(Math.floor((s % 3600) / 60)).padStart(2, '0')}m`;
}

/* ---------- help buttons and explained labels (pure) ---------- */

/* The small (i): opens the explanation of `topic`. */
const helpBtn = (topic, what = '') =>
  `<button type="button" class="info" data-action="help" data-topic="${esc(topic)}" title="Explain${what ? `: ${esc(what)}` : ''}" aria-label="Explain ${esc(what || topic)}">i</button>`;

/* A coloured label that explains itself when pressed (and on hover). Plain when there is no text for it. */
function chip(cls, text, topic) {
  const entry = TOPICS[topic];
  if (!entry) return `<span class="chip ${cls}">${text}</span>`;
  return `<button type="button" class="chip help ${cls}" data-action="help" data-topic="${esc(topic)}" title="${esc(entry.short)}">${text}</button>`;
}

function verdictLabel(verdict) {
  const text = esc(String(verdict).replace('_', ' '));
  return TOPICS[`verdict-${verdict}`]
    ? `<button type="button" class="vlabel verdict-${esc(verdict)}" data-action="help" data-topic="verdict-${esc(verdict)}" title="${esc(TOPICS[`verdict-${verdict}`].short)}">${text}</button>`
    : `<span class="verdict-${esc(verdict)}">${text}</span>`;
}

/* "20261109-213944-cpu-2" -> "2026-11-09 21:39:44" (the id carries the local start time) */
function whenOfId(id) {
  const m = /^(\d{4})(\d{2})(\d{2})-(\d{2})(\d{2})(\d{2})/.exec(id || '');
  return m ? `${m[1]}-${m[2]}-${m[3]} ${m[4]}:${m[5]}:${m[6]}` : id || '';
}

const STATUS_CLASS = {
  running: 'info', succeeded: 'ok', skipped: 'ok', failed: 'bad', crashed: 'bad', interrupted: 'warn', cancelled: 'warn', queued: '',
};
const STATUS_TEXT = { succeeded: 'passed', skipped: 'nothing to test' };

const statusChip = (status) => chip(STATUS_CLASS[status] ?? '', esc(STATUS_TEXT[status] ?? status), `status-${status}`);

function countChips(summary) {
  if (!summary) return '';
  const parts = [['total', 'tests', ''], ['passed', 'passed', 'ok'], ['unverified', 'unverified', 'warn'], ['skipped', 'skipped', 'warn'],
    ['not_supported', 'not supported', 'warn'], ['failed', 'failed', 'bad'], ['panicked', 'panicked', 'bad'],
    ['timed_out', 'timed out', 'bad'], ['crashed', 'crashed', 'bad']];
  return parts
    .filter(([key]) => key === 'total' || summary[key] > 0)
    .map(([key, label, cls]) => chip(cls, `${summary[key]} ${label}`, key === 'total' ? 'verdict-total' : `verdict-${key}`))
    .join(' ');
}

/* ---------- live run (pure) ---------- */

const pct = (fraction) => (fraction == null ? null : Math.min(100, Math.floor(fraction * 100)));

function stepText(step) {
  const parts = [];
  if (step.total != null) parts.push(`${step.done}/${step.total} ${esc(step.unit ?? '')}`.trim());
  else if (step.done > 0) parts.push(`${step.done} ${esc(step.unit ?? '')}`.trim());
  const p = pct(step.fraction);
  if (p != null && step.state === 'running') parts.push(`${p}%`);
  if (step.state === 'running') {
    if (step.unit === 's' && step.total != null) parts.push(`${fmtDur((step.total - step.done) * 1000)} left`);
    else if (step.eta_secs != null) parts.push(`~${fmtDur(step.eta_secs * 1000)} left`);
  }
  return parts.join(' · ');
}

/* Roots, everything running, and the latest few finished steps: a CPU run has hundreds of families. */
function visibleSteps(steps, keepFinished = 3) {
  const finished = steps.filter((s) => s.depth > 0 && s.state !== 'running');
  const keep = new Set(finished.slice(-keepFinished).map((s) => s.id));
  const shown = steps.filter((s) => s.depth === 0 || s.state === 'running' || keep.has(s.id));
  return { shown, hidden: steps.length - shown.length };
}

function stepsHtml(steps) {
  const { shown, hidden } = visibleSteps(steps);
  const rows = shown.map((s) => {
    const p = pct(s.fraction);
    const cls = s.state === 'running' ? (p == null ? 'indeterminate' : '') : s.state === 'done' ? 'finished' : s.state === 'failed' ? 'failed' : 'finished';
    const width = s.state === 'running' ? (p ?? 100) : 100;
    const mark = s.state === 'running' ? '' : s.state === 'done' ? '✓ ' : s.state === 'failed' ? '✗ ' : '– ';
    const current = s.state === 'running' && s.current ? `<div class="muted small mono">${esc(s.current)}</div>` : '';
    return `<div class="label" style="padding-left:${s.depth * 14}px" title="${esc(s.label)}">${mark}${esc(s.label)}</div>
      <div class="bar ${cls}"><i style="width:${width}%"></i></div>
      <div class="${s.state === 'running' ? '' : 'done'}">${stepText(s)}${current}</div>`;
  });
  const more = hidden > 0 ? `<div class="muted small" style="grid-column:1/-1">${hidden} finished step(s) not shown</div>` : '';
  return `<div class="steps">${rows.join('')}${more}</div>`;
}

function findingsList(findings) {
  if (!findings.length) return '';
  const items = [...findings].reverse().slice(0, 8).map((f) => {
    const extra = f.detail ? ` <span class="muted">${esc(f.detail)}</span>` : f.value ? ` <span class="muted">= ${esc(f.value)}</span>` : '';
    return `<li>${verdictLabel(f.verdict)} ${esc(f.name)}${extra}</li>`;
  });
  return `<ul class="list">${items.join('')}</ul>`;
}

function runHtml(run, { job = null, foreign = false, id = null } = {}) {
  const root = run.steps.find((s) => s.depth === 0);
  const overall = root && pct(root.fraction);
  const where = foreign ? chip('', 'started from a terminal', 'foreign') : '';
  const cancel = job ? `<button class="danger" data-action="cancel-job" data-id="${job.id}">Stop</button>` : '';
  const open = id || job?.run;
  const link = open ? `<button data-action="open-run" data-id="${esc(open)}">Details</button>` : '';
  const logs = run.logs.length ? `<ul class="list muted small">${run.logs.slice(-4).map(([, m]) => `<li class="mono">${esc(m)}</li>`).join('')}</ul>` : '';
  return `<div class="run">
    <header><strong>${esc(run.title)}</strong> ${statusChip(run.status)} ${where}
      <span class="muted">${fmtDur(run.elapsed_ms)}${overall != null ? ` · ${overall}%` : ''}</span>
      <span style="margin-left:auto" class="row start">${link}${cancel}</span></header>
    <div class="chips">${countChips(run.summary)}</div>
    ${stepsHtml(run.steps)}
    ${findingsList(run.notable)}
    ${logs}
  </div>`;
}

function liveHtml(state) {
  const runs = [];
  if (state.active) runs.push(runHtml(state.active.run, { job: state.active.job }));
  for (const f of state.foreign) runs.push(runHtml(f.run, { foreign: true, id: f.id }));
  return runs.length ? runs.join('') : '<p class="muted">Nothing is running.</p>';
}

function queueHtml(state) {
  if (!state.queue.length) return '';
  const rows = state.queue.map((j) => `<tr><td>#${j.id}</td><td>${esc(j.module)}</td><td class="mono">${esc(j.args.join(' '))}</td>
    <td><button class="danger" data-action="cancel-job" data-id="${j.id}">Remove</button></td></tr>`);
  return `<table><tr><th>Job</th><th>Check</th><th>Arguments</th><th></th></tr>${rows.join('')}</table>`;
}

/* ---------- cards and runs table (pure) ---------- */

const AVAILABILITY = {
  ok: ['ok', 'available'], unavailable: ['info', 'not available here'], failed: ['bad', 'check failed'],
  not_built: ['', 'not built in'], probing: ['warn', 'checking…'],
};

function availabilityHtml(a) {
  if (!a) return '<span class="chip">…</span>';
  const [cls, text] = AVAILABILITY[a.state] ?? ['', a.state];
  const devices = a.devices?.length ? `<div class="muted small">${a.devices.map(esc).join('<br>')}</div>` : '';
  const detail = a.detail && !a.devices?.length ? `<div class="muted small">${esc(a.detail)}</div>` : '';
  return `<span class="chip ${cls}">${text}</span>${helpBtn('availability', 'what this machine can do')}${devices}${detail}`;
}

function lastRunHtml(run) {
  if (!run) return '<p class="muted small">Never run here.</p>';
  const took = run.finished_ms ? ` in ${fmtDur(run.finished_ms - run.started_ms)}` : '';
  return `<p class="small">Last: ${statusChip(run.status)} <span class="muted">${esc(whenOfId(run.id))}${took}</span><br>${countChips(run.summary)}</p>`;
}

const canStart = (m) => !m.availability || m.availability.state === 'ok' || m.availability.state === 'probing';

function modulesHtml(state) {
  return state.modules.map((m) => `<div class="card ${m.running ? 'running' : ''}">
      <h3>${esc(m.title)}${helpBtn(`module-${m.key}`, m.title)}</h3>
      <p class="muted small">${esc(m.about)}</p>
      <div>${availabilityHtml(m.availability)}</div>
      ${lastRunHtml(m.last_run)}
      <div class="actions">
        <button class="primary" data-action="start" data-module="${esc(m.key)}" ${canStart(m) ? '' : 'disabled'}>Run…</button>
        ${m.last_run ? `<button data-action="open-run" data-id="${esc(m.last_run.id)}">Last run</button>` : ''}
      </div></div>`).join('')
    + `<div class="card"><h3>Re-check this machine</h3><p class="muted small">Asks the GPU drivers again what they can do, in a separate process.</p>
       <div class="actions"><button data-action="reprobe">Check again</button></div></div>`;
}

function runsHtml(state) {
  if (!state.runs.length) return '<p class="muted">No runs kept yet. Run a check above, or run <code>hodow test</code> in a terminal.</p>';
  const rows = state.runs.map((r) => {
    const took = r.finished_ms ? fmtDur(r.finished_ms - r.started_ms) : '';
    return `<tr class="click" data-action="open-run" data-id="${esc(r.id)}"><td class="mono">${esc(whenOfId(r.id))}</td><td>${esc(r.module)}</td>
      <td>${statusChip(r.status)}</td><td>${took}</td><td>${countChips(r.summary)}</td></tr>`;
  });
  return `<table><tr><th>Started</th><th>Check</th><th>Status</th><th>Took</th><th>Result</th></tr>${rows.join('')}</table>`;
}

/* ---------- run detail (pure) ---------- */

const VERDICTS = ['notable', 'all', 'failed', 'crashed', 'timed_out', 'panicked', 'unverified', 'skipped', 'not_supported', 'passed'];

function detailHtml(detail, view) {
  const { meta, pinned, files } = detail;
  const fileLinks = files.map((f) => `<a href="/api/runs/${encodeURIComponent(meta.id)}/files/${encodeURIComponent(f)}" target="_blank">${esc(f)}</a>`).join(' · ');
  const options = VERDICTS.map((v) => `<option value="${v}" ${v === view.verdict ? 'selected' : ''}>${v.replace('_', ' ')}</option>`).join('');
  const f = view.findings;
  const rows = f ? f.items.map((x) => `<tr><td>${verdictLabel(x.verdict)}</td><td class="mono">${esc(x.name)}</td>
      <td class="small">${esc(x.detail ?? '')}${x.value ? ` <span class="muted">= ${esc(x.value)}</span>` : ''}</td></tr>`).join('') : '';
  const last = f ? Math.min(f.offset + f.items.length, f.total) : 0;
  return `<h3>${esc(meta.title)} ${statusChip(meta.status)}</h3>
    <p class="muted small">${esc(meta.id)} · ${esc(meta.host ?? 'unknown host')} (${esc(meta.os)} ${esc(meta.arch)}) · hodow ${esc(meta.version)}
      ${meta.finished_ms ? ` · took ${fmtDur(meta.finished_ms - meta.started_ms)}` : ''}</p>
    <p class="mono small">${esc((meta.args ?? []).join(' '))}</p>
    <div class="chips">${countChips(meta.summary)}</div>
    ${fileLinks ? `<p class="small">Files: ${fileLinks}</p>` : ''}
    <p class="row start">
      <button data-action="pin-run" data-id="${esc(meta.id)}" data-pinned="${pinned ? 0 : 1}">${pinned ? 'Unpin (may be trimmed)' : 'Pin (never trimmed)'}</button>${helpBtn('pin', 'pinning')}
      <button class="danger" data-action="delete-run" data-id="${esc(meta.id)}" ${pinned || meta.status === 'running' ? 'disabled' : ''}>Delete</button></p>
    <div class="row start"><label>Show <select id="f-verdict">${options}</select></label>${helpBtn('filter', 'which results are listed')}
      <label>Search <input id="f-q" value="${esc(view.q)}" placeholder="name or detail"></label>
      <span class="muted small">${f ? `${f.total === 0 ? 0 : f.offset + 1}–${last} of ${f.total}` : 'loading…'}</span>
      <button data-action="page" data-dir="-1" ${view.offset === 0 ? 'disabled' : ''}>Prev</button>
      <button data-action="page" data-dir="1" ${f && last >= f.total ? 'disabled' : ''}>Next</button></div>
    <table><tr><th>Verdict</th><th>Test</th><th>Detail</th></tr>${rows || '<tr><td colspan="3" class="muted">Nothing to show.</td></tr>'}</table>`;
}

/* ---------- what each check asks before it is queued (pure data) ---------- */

const FLOWS = { label: 'Also run the processing flows', args: ['--flows'] };
const START = {
  cpu: { presets: [
    { label: 'Every test in its own process (recommended)', args: ['test', 'cpu', '--isolate'],
      about: 'One result per test. A crash or hang is blamed on that one test and the run goes on. Seconds to minutes.' },
    { label: 'Plain run: faster to start, only per-extension counts', args: ['test', 'cpu'],
      about: 'Everything in one process: a crash ends the run, and no per-test results are kept.' }], flags: [FLOWS] },
  gl: { presets: [
    { label: 'Headless, one process per test', args: ['test', 'gl', '--isolate', '--no-window'],
      about: 'Needs no display. A driver crash or a hung GPU costs only the test that caused it.' },
    { label: 'With a window', args: ['test', 'gl', '--isolate'], about: 'Needs a desktop session; the tests draw to a real window.' }],
    flags: [{ label: 'Software rendering', args: ['--force-software'] }] },
  vulkan: { presets: [{ label: 'Every device', args: ['test', 'vulkan'], about: 'A compute kernel with a known answer on each Vulkan device.' }], flags: [FLOWS] },
  stress: { presets: [{ label: 'All cores', args: ['cpu', '--stress'], about: 'The whole CPU suite on every core at once; a core that differs from the others is the suspect.' }],
    number: { label: 'Seconds', arg: '--stress-secs', value: 60 } },
  burn: { presets: [
    { label: 'Full run', args: ['burn'], about: 'CPU, then memory, then GPU, then all together, for the total duration below. Run it when a machine is suspected of being unstable.' },
    { label: 'One pass of every sub-test', args: ['burn', '--quick'], noText: true, about: 'Each sub-test once and nothing more: a quick look that everything starts.' }],
    text: { label: 'Total duration (e.g. 90s, 10m, 8h)', arg: '--duration', value: '10m' } },
  bench: { presets: [
    { label: 'Quick: a few minutes', args: ['bench', '--quick'], about: 'The camera pipeline and the best-known variants only.' },
    { label: 'Default', args: ['bench'], about: 'A broad set of kernels and backends.' },
    { label: 'Everything: an hour or more', args: ['bench', '--full'], about: 'Every size, radius and work-group shape. Leave the machine alone while it runs.' }] },
  cts: { presets: [
    { label: 'OpenGL ES 2.0 (dEQP-GLES2)', args: ['cts', '--case', 'dEQP-GLES2.*'], about: 'About 17,000 cases.' },
    { label: 'OpenGL ES 3.0 (dEQP-GLES3)', args: ['cts', '--case', 'dEQP-GLES3.*'], about: 'About 45,000 cases.' },
    { label: 'OpenGL ES 3.1 (dEQP-GLES31)', args: ['cts', '--case', 'dEQP-GLES31.*'], about: 'About 38,000 cases.' },
    { label: 'Desktop OpenGL 4.5 (KHR-GL45)', args: ['cts', '--case', 'KHR-GL45.*'], about: 'Needs a driver that gives a 4.5 core context.' },
    { label: 'Vulkan (dEQP-VK), a very long run', args: ['cts', '--case', 'dEQP-VK.*'], about: 'Hundreds of thousands of cases: many hours.' },
    { label: 'Only what I write in the extra arguments, e.g. --case dEQP-VK.compute.*', args: ['cts'], about: 'A case pattern is required.' }] },
  'gpu-memtest': { presets: [{ label: 'GPU memory test', args: ['gpu', '--memtest'], about: 'Bit patterns written to graphics memory and read back.' }],
    number: { label: 'Buffer size (MB)', arg: '--memtest-mb', value: 64 } },
};

function buildArgs(def, form) {
  const preset = def.presets[form.preset ?? 0];
  const args = [...preset.args];
  (def.flags ?? []).forEach((flag, i) => { if (form.flags?.[i]) args.push(...flag.args); });
  if (def.number && form.number !== '' && form.number != null) args.push(def.number.arg, String(form.number));
  if (def.text && !preset.noText && form.text) args.push(def.text.arg, form.text);
  const extra = (form.extra ?? '').trim();
  if (extra) args.push(...extra.split(/\s+/));
  return args;
}

/* ---------- the help window (pure) ---------- */

const GROUP_ORDER = ['Start here', 'The checks', 'Reading results', 'The page'];

function glossaryHtml() {
  const entries = Object.entries(TOPICS);
  const groups = GROUP_ORDER.map((group) => {
    const items = entries.filter(([, t]) => t.group === group)
      .map(([key, t]) => `<li><button type="button" class="link" data-action="help" data-topic="${esc(key)}">${esc(t.title)}</button> <span class="muted">${esc(t.short)}</span></li>`);
    return items.length ? `<h4>${esc(group)}</h4><ul class="list">${items.join('')}</ul>` : '';
  });
  return `<h3>Help</h3>${groups.join('')}`;
}

function helpHtml(topic) {
  if (topic === 'index') return glossaryHtml();
  const entry = TOPICS[topic];
  if (!entry) return `<h3>No explanation</h3><p class="muted">There is no text for “${esc(topic)}” yet.</p>`;
  const related = (entry.related ?? []).filter((r) => TOPICS[r])
    .map((r) => `<button type="button" class="link" data-action="help" data-topic="${esc(r)}">${esc(TOPICS[r].title)}</button>`);
  return `<h3>${esc(entry.title)}</h3><div class="help-text">${entry.body}</div>
    ${related.length ? `<p class="small muted">See also: ${related.join(' · ')}</p>` : ''}`;
}

/* ---------- browser side ---------- */

if (typeof document !== 'undefined') {
  const $ = (id) => document.getElementById(id);
  let state = null;
  let socket = null;
  let startModule = null;
  let view = null;

  const paint = (el, html) => { if (el.dataset.html !== html) { el.dataset.html = html; el.innerHTML = html; } };

  function render() {
    $('host').textContent = state.host;
    $('runs-where').textContent = state.data_dir;
    paint($('modules'), modulesHtml(state));
    paint($('live'), liveHtml(state));
    paint($('queue'), queueHtml(state));
    $('queue-section').hidden = state.queue.length === 0;
    paint($('runs'), runsHtml(state));
  }

  function connect() {
    socket = new WebSocket(`${location.protocol === 'https:' ? 'wss' : 'ws'}://${location.host}/ws`);
    socket.onopen = () => { $('conn').className = 'pill live'; $('conn').textContent = 'live'; };
    socket.onmessage = (m) => { state = JSON.parse(m.data); render(); };
    socket.onclose = () => { $('conn').className = 'pill down'; $('conn').textContent = 'disconnected - retrying'; setTimeout(connect, 2000); };
  }

  const api = async (method, path, body) => {
    const response = await fetch(path, { method, headers: { 'content-type': 'application/json' }, body: body ? JSON.stringify(body) : undefined });
    const data = await response.json().catch(() => ({}));
    if (!response.ok) throw new Error(data.error ?? response.statusText);
    return data;
  };

  /* queue dialog */
  function readForm() {
    const def = START[startModule];
    return {
      preset: Number(document.querySelector('input[name=preset]:checked')?.value ?? 0),
      flags: [...document.querySelectorAll('input[name=flag]')].map((c) => c.checked),
      number: $('start-number')?.value ?? '', text: $('start-text')?.value ?? '', extra: $('start-extra').value,
    };
  }
  const refreshPreview = () => { $('start-preview').textContent = `hodow ${buildArgs(START[startModule], readForm()).join(' ')}`; };

  function openStart(key) {
    startModule = key;
    const def = START[key];
    const module = state.modules.find((m) => m.key === key);
    $('start-title').innerHTML = `${esc(module.title)}${helpBtn(`module-${key}`, module.title)}`;
    const presets = def.presets.map((p, i) => `<label><input type="radio" name="preset" value="${i}" ${i === 0 ? 'checked' : ''}> ${esc(p.label)}${p.about ? `<span class="muted small block">${esc(p.about)}</span>` : ''}</label>`).join('');
    const flags = (def.flags ?? []).map((f) => `<label><input type="checkbox" name="flag"> ${esc(f.label)}</label>`).join('');
    const number = def.number ? `<label>${esc(def.number.label)} <input id="start-number" type="number" min="1" value="${def.number.value}"></label>` : '';
    const text = def.text ? `<label>${esc(def.text.label)} <input id="start-text" value="${esc(def.text.value)}"></label>` : '';
    $('start-fields').innerHTML = presets + flags + number + text;
    $('start-extra').value = '';
    $('start-error').textContent = '';
    refreshPreview();
    $('start-dialog').showModal();
  }

  $('start-form').addEventListener('input', refreshPreview);
  $('start-cancel').onclick = () => $('start-dialog').close();
  $('start-x').onclick = () => $('start-dialog').close();
  $('start-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    try {
      await api('POST', '/api/jobs', { args: buildArgs(START[startModule], readForm()) });
      $('start-dialog').close();
    } catch (err) {
      $('start-error').textContent = err.message;
    }
  });

  /* run detail dialog */
  async function loadDetail() {
    const id = view.id;
    const [detail, findings] = await Promise.all([
      api('GET', `/api/runs/${encodeURIComponent(id)}`),
      api('GET', `/api/runs/${encodeURIComponent(id)}/findings?verdict=${view.verdict}&q=${encodeURIComponent(view.q)}&offset=${view.offset}&limit=${view.limit}`).catch(() => null),
    ]);
    if (view.id !== id) return;
    view.detail = detail;
    view.findings = findings;
    drawDetail();
  }

  function drawDetail() {
    const keep = document.activeElement?.id;
    $('run-detail').innerHTML = detailHtml(view.detail, view);
    if (keep === 'f-q') { const q = $('f-q'); q.focus(); q.setSelectionRange(q.value.length, q.value.length); }
  }

  async function openRun(id) {
    view = { id, verdict: 'notable', q: '', offset: 0, limit: 100, detail: null, findings: null };
    $('run-detail').textContent = 'Loading…';
    if (!$('run-dialog').open) $('run-dialog').showModal();
    try { await loadDetail(); } catch (err) { $('run-detail').textContent = err.message; }
  }

  $('run-close').onclick = () => $('run-dialog').close();
  $('run-x').onclick = () => $('run-dialog').close();
  $('help-close').onclick = () => $('help-dialog').close();
  $('help-x').onclick = () => $('help-dialog').close();

  function openHelp(topic) {
    $('help-body').innerHTML = helpHtml(topic);
    $('help-body').scrollTop = 0;
    if (!$('help-dialog').open) $('help-dialog').showModal();
  }
  $('run-detail').addEventListener('change', (e) => { if (e.target.id === 'f-verdict') { view.verdict = e.target.value; view.offset = 0; loadDetail(); } });
  let searching = 0;
  $('run-detail').addEventListener('input', (e) => {
    if (e.target.id !== 'f-q') return;
    clearTimeout(searching);
    view.q = e.target.value;
    searching = setTimeout(() => { view.offset = 0; loadDetail(); }, 300);
  });

  document.addEventListener('click', async (e) => {
    const el = e.target.closest('[data-action]');
    if (!el) return;
    const { action, id, module } = el.dataset;
    try {
      if (action === 'help') openHelp(el.dataset.topic);
      else if (action === 'start') openStart(module);
      else if (action === 'open-run') openRun(id);
      else if (action === 'cancel-job') await api('DELETE', `/api/jobs/${id}`);
      else if (action === 'reprobe') await api('POST', '/api/probe');
      else if (action === 'pin-run') { await api('POST', `/api/runs/${encodeURIComponent(id)}/pin`, { pinned: el.dataset.pinned === '1' }); await loadDetail(); }
      else if (action === 'delete-run' && confirm(`Delete ${id}?`)) { await api('DELETE', `/api/runs/${encodeURIComponent(id)}`); $('run-dialog').close(); }
      else if (action === 'page') { view.offset = Math.max(0, view.offset + Number(el.dataset.dir) * view.limit); await loadDetail(); }
    } catch (err) {
      alert(err.message);
    }
  });

  connect();
}

if (typeof module !== 'undefined') {
  module.exports = { esc, fmtDur, whenOfId, statusChip, countChips, stepsHtml, visibleSteps, runHtml, liveHtml, queueHtml, modulesHtml, runsHtml,
    detailHtml, buildArgs, START, availabilityHtml, stepText, helpBtn, helpHtml, glossaryHtml, verdictLabel, TOPICS };
}
