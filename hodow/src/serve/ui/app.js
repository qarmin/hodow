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
  `<button type="button" class="ibtn" data-action="help" data-topic="${esc(topic)}" title="Explain${what ? `: ${esc(what)}` : ''}" aria-label="Explain ${esc(what || topic)}">i</button>`;

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

/* Microseconds as the unit that reads best: most cases are far below a millisecond, a few take seconds. */
function fmtMicros(us) {
  if (us == null) return '';
  if (us < 1000) return `${us} µs`;
  if (us < 1e6) return `${(us / 1000).toFixed(us < 1e4 ? 1 : 0)} ms`;
  return `${(us / 1e6).toFixed(us < 1e7 ? 1 : 0)} s`;
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
    + recheckHtml(state.probe);
}

const clockOf = (ms) => new Date(ms).toTimeString().slice(0, 8);

function recheckHtml(probe) {
  const running = probe?.running;
  const status = running
    ? '<p class="small">Asking the OpenGL and Vulkan drivers, one after the other (each gets up to 20 s)…</p><div class="bar indeterminate"><i></i></div>'
    : `<p class="muted small">${probe?.finished_ms ? `Last checked at ${clockOf(probe.finished_ms)}.` : 'Not checked yet.'}</p>`;
  return `<div class="card ${running ? 'running' : ''}"><h3>Re-check this machine</h3>
    <p class="muted small">Asks the GPU drivers again what they can do, in a separate process.</p>${status}
    <div class="actions"><button data-action="reprobe" ${running ? 'disabled' : ''}>${running ? 'Checking…' : 'Check again'}</button></div></div>`;
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

const VERDICT_LABEL = { notable: 'everything except passed', all: 'all' };
const VERDICTS = ['notable', 'all', 'failed', 'crashed', 'timed_out', 'panicked', 'unverified', 'skipped', 'not_supported', 'passed'];

function detailHtml(detail, view) {
  const { meta, pinned, files } = detail;
  const fileLinks = files.map((f) => `<a href="/api/runs/${encodeURIComponent(meta.id)}/files/${encodeURIComponent(f)}" target="_blank">${esc(f)}</a>`).join(' · ');
  const options = VERDICTS.map((v) => `<option value="${v}" ${v === view.verdict ? 'selected' : ''}>${VERDICT_LABEL[v] ?? v.replace('_', ' ')}</option>`).join('');
  const f = view.findings;
  const rows = f ? f.items.map((x) => `<tr><td class="verdict">${verdictLabel(x.verdict)}</td><td class="mono">${esc(x.name)}</td>
      <td class="num small">${fmtMicros(x.duration_us)}</td>
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
    <table><tr><th>Verdict</th><th>Test</th><th class="num">Time</th><th>Detail</th></tr>${rows || '<tr><td colspan="4" class="muted">Nothing to show.</td></tr>'}</table>`;
}

/* ---------- what each check asks before it is queued (pure data) ----------
   A preset is a radio button; `off` lists the fields it makes meaningless (they grey out and add nothing to the command), and
   `requires` the fields that must be filled in. A field is a `flag` (checkbox), `number`, `text` (a list: `join` makes one
   comma-separated argument, `multi` one argument per word, `repeat` the flag once per word) or `select`, and `needs` greys it
   out until another flag is ticked. Everything has a one-line `about`: nobody should have to know the command line. */

const FLOWS = [
  { id: 'flows', type: 'flag', label: 'Also run the pipeline checks', args: ['--flows'],
    about: 'Runs 15 small made-up jobs, such as processing a camera frame, sorting or multiplying matrices, and checks every answer bit for bit. It finds faults that a single instruction does not show.' },
  { id: 'flows-size', type: 'select', label: 'Size of the pipeline checks', arg: '--flows-size', value: 'small', needs: 'flows',
    options: [['small', 'Small: a few seconds'], ['full', 'Full: HD frames, a few minutes']], about: 'Only used when the pipeline checks are on.' },
];
const TIME_LIMIT_MS = (arg, value) => ({ id: 'limit', type: 'number', label: 'Time limit per test (ms)', arg, placeholder: value,
  about: 'A test that has not finished by then is stopped and counted as timed out. Leave empty for the default.' });
const WORKERS = { id: 'jobs', type: 'number', label: 'Parallel workers', arg: '-j', value: 1, dflt: 1, min: 1,
  about: 'More workers finish sooner, but cases can disturb each other. Vulkan memory cases always run alone.' };

const CTS_ROOTS = ['dEQP-GLES2.*', 'dEQP-GLES3.*', 'dEQP-GLES31.*', 'KHR-GL45.*', 'dEQP-VK.*'];
const START = {
  cpu: { presets: [
    { label: 'Every test in its own process (recommended)', args: ['test', 'cpu', '--isolate'],
      about: 'One result per test. A crash or hang is blamed on that one test and the run goes on. Seconds to minutes.' },
    { label: 'Plain run: faster to start, only per-extension counts', args: ['test', 'cpu'], off: ['limit'],
      about: 'Everything in one process: a crash ends the run, and no per-test results are kept.' }],
    fields: [
      { id: 'features', type: 'text', label: 'Only these instruction sets', arg: '-e', join: ',', placeholder: 'sse2, avx2',
        about: 'Names separated by commas or spaces. Empty: every set this processor has.' },
      { id: 'tests', type: 'text', label: 'Only these tests', arg: '-t', multi: true, placeholder: 'test_x86_adx_addcarry_u32',
        about: 'Exact test names, separated by spaces. Empty: all of them.' },
      { id: 'skip', type: 'text', label: 'Leave these tests out', arg: '-s', join: ',', placeholder: 'test_name_1, test_name_2',
        about: 'Exact test names, separated by commas. Use it for a test you already know hangs.' },
      { id: 'iterations', type: 'number', label: 'Repeat every test', arg: '-n', min: 1, placeholder: '1',
        about: 'How many times each test runs. A fault that comes and goes shows up sooner with more repeats.' },
      TIME_LIMIT_MS('--isolate-timeout', '10000'), ...FLOWS] },
  gl: { presets: [
    { label: 'Headless, one process per test', args: ['test', 'gl', '--isolate', '--no-window'],
      about: 'Needs no display. A driver crash or a hung GPU costs only the test that caused it.' },
    { label: 'With a window', args: ['test', 'gl', '--isolate'], about: 'Needs a desktop session; the tests draw to a real window.' }],
    fields: [
      { id: 'quick', type: 'flag', label: 'Only the quick tests', args: ['--quick'],
        about: 'The fast tests that check the picture that was drawn: about a second in total.' },
      { id: 'software', type: 'flag', label: 'Software rendering', args: ['--force-software'],
        about: 'Uses the processor instead of the graphics card. For comparing, or when the real driver crashes.' },
      { id: 'api', type: 'select', label: 'Which OpenGL', arg: '--gl-api', value: 'auto', dflt: 'auto',
        options: [['auto', 'Whatever the driver prefers'], ['opengl', 'Desktop OpenGL'], ['opengl:3.3', 'Desktop OpenGL 3.3'], ['opengl:4.6', 'Desktop OpenGL 4.6'],
          ['gles', 'OpenGL ES'], ['gles:2.0', 'OpenGL ES 2.0'], ['gles:3.0', 'OpenGL ES 3.0']],
        about: 'Tests the driver cannot do under this choice show as not supported.' },
      TIME_LIMIT_MS('--isolate-timeout-ms', '30000')] },
  vulkan: { presets: [{ label: 'Every device', args: ['test', 'vulkan'], about: 'A compute kernel with a known answer on each Vulkan device.' }], fields: FLOWS },
  stress: { presets: [{ label: 'All cores', args: ['cpu', '--stress'], about: 'The whole CPU suite on every core at once; a core that differs from the others is the suspect.' }],
    fields: [{ id: 'secs', type: 'number', label: 'How long (seconds)', arg: '--stress-secs', value: 60, min: 1, about: 'Longer finds faults that need heat or luck.' }] },
  burn: { presets: [
    { label: 'Full run', args: ['burn'], about: 'CPU, then memory, then GPU, then all together, for the total time below. Use it when a machine is suspected of being unstable.' },
    { label: 'One pass of every sub-test', args: ['burn', '--quick'], off: ['duration'], about: 'Each sub-test once and nothing more: a quick look that everything starts.' }],
    fields: [
      { id: 'duration', type: 'text', label: 'Total time (e.g. 90s, 10m, 8h)', arg: '--duration', value: '10m', about: 'Shared between the phases.' },
      { id: 'phases', type: 'set', label: 'Phases', skipArg: '--skip', value: ['cpu', 'memory', 'gpu', 'combined'],
        options: [['cpu', 'CPU'], ['memory', 'Memory'], ['gpu', 'GPU'], ['combined', 'All together']], about: 'Untick what you do not want to load.' },
      { id: 'ram', type: 'number', label: 'RAM to test (MB)', arg: '--ram-mb', min: 1, placeholder: 'half of the free memory',
        about: 'More finds more, but leave room for the system or it will start swapping.' },
      { id: 'gpumem', type: 'number', label: 'GPU memory to test (MB)', arg: '--gpu-mb', min: 1, placeholder: 'chosen from the driver',
        about: 'On a board that shares memory with the processor, RAM and GPU memory are one pool.' },
      { id: 'temp', type: 'number', label: 'Stop when hotter than (°C)', arg: '--max-temp', min: 1, placeholder: 'no limit',
        about: 'Stops the run early to protect the hardware.' },
      { id: 'hang', type: 'number', label: 'Hang limit (seconds)', arg: '--hang-timeout', min: 1, placeholder: '30',
        about: 'A sub-test that shows no progress for this long counts as hung.' }] },
  bench: { presets: [
    { label: 'Quick: a few minutes', args: ['bench', '--quick'], about: 'The camera pipeline and the best-known variants only.' },
    { label: 'Default', args: ['bench'], about: 'A broad set of kernels and backends.' },
    { label: 'Everything: an hour or more', args: ['bench', '--full'], about: 'Every size, radius and work-group shape. Leave the machine alone while it runs.' }],
    fields: [
      { id: 'kernel', type: 'text', label: 'Only these tasks', arg: '-k', join: ',', placeholder: 'debayer, blur, r=8',
        about: 'Part of a task name, separated by commas. Empty: all tasks.' },
      { id: 'backend', type: 'text', label: 'Only these backends', arg: '-b', join: ',', placeholder: 'cpu, opencl',
        about: 'Part of a backend name, separated by commas. Empty: every backend.' },
      { id: 'soak', type: 'number', label: 'Then a long heat test (seconds)', arg: '--soak', min: 1, placeholder: 'off',
        about: 'Keeps the best variant running and records how speed and temperature move.' },
      { id: 'hang', type: 'number', label: 'Hang limit (seconds)', arg: '--hang-timeout', min: 1, placeholder: '60',
        about: 'A row that finishes no frame for this long counts as hung.' }] },
  cts: { presets: [
    ...[['OpenGL ES 2.0 (dEQP-GLES2)', 'About 17,000 cases.'], ['OpenGL ES 3.0 (dEQP-GLES3)', 'About 45,000 cases.'],
      ['OpenGL ES 3.1 (dEQP-GLES31)', 'About 38,000 cases.'], ['Desktop OpenGL 4.5 (KHR-GL45)', 'Needs a driver that gives a 4.5 core context.'],
      ['Vulkan (dEQP-VK), a very long run', 'Hundreds of thousands of cases: many hours.']]
      .map(([label, about], i) => ({ label, about, args: ['cts', '--case', CTS_ROOTS[i]], off: ['case'] })),
    { label: 'Only the cases I name below', args: ['cts'], requires: ['case'], about: 'For one group or a single case.' }],
    fields: [
      { id: 'case', type: 'text', label: 'Cases to run', arg: '--case', repeat: true, placeholder: 'dEQP-VK.compute.*',
        about: 'Case names or patterns with *, separated by spaces.' },
      { id: 'slow', type: 'flag', label: 'Skip the very slow cases', args: ['--skip-slow'], checked: true,
        about: 'Two timing groups (flush_finish) that run for minutes on a slow driver and get killed by the time limit. They say nothing about conformance.' },
      { id: 'exclude', type: 'text', label: 'Also skip these cases', arg: '--exclude', repeat: true, placeholder: 'dEQP-GLES2.functional.fbo.*',
        about: 'Names or patterns with *, separated by spaces.' },
      { id: 'timeout', type: 'number', label: 'Time limit per case (seconds)', arg: '--timeout-secs', value: 60, dflt: 60, min: 1,
        about: 'A case that reports nothing for this long is killed and counted as timed out.' },
      { id: 'alone', type: 'flag', label: 'Every case in its own process', args: ['--isolate-per-test'],
        about: 'Much slower, but a crash is pinned on one case at once.' },
      WORKERS,
      { id: 'device', type: 'number', label: 'Which device (1 is the first)', arg: '--device-id', value: 1, dflt: 1, min: 1, about: 'For a machine with several GPUs.' },
      { id: 'validation', type: 'flag', label: 'Also check how the API is used', args: ['--validation'],
        about: 'Turns on the validation layer. It changes driver behaviour, so this is no longer a conformance run.' }] },
  'gpu-memtest': { presets: [{ label: 'GPU memory test', args: ['gpu', '--memtest'], about: 'Bit patterns written to graphics memory and read back.' }],
    fields: [{ id: 'mb', type: 'number', label: 'Buffer size (MB)', arg: '--memtest-mb', value: 64, min: 1, about: 'Cover most of the memory, but leave room for the system.' }] },
};

const words = (text) => String(text ?? '').split(/[\s,]+/).filter(Boolean);

/* What the dialog starts with: `{ preset, values: { fieldId: value } }`. */
function initialForm(def) {
  const values = {};
  for (const f of def.fields ?? []) values[f.id] = f.type === 'flag' ? !!f.checked : (f.value ?? (f.type === 'set' ? [] : ''));
  return { preset: 0, values };
}

/* Ids of the fields that do nothing right now: the preset ignores them, or the flag they depend on is off. */
function disabledFields(def, form) {
  const off = new Set(def.presets[form.preset ?? 0].off ?? []);
  for (const f of def.fields ?? []) if (f.needs && !form.values?.[f.needs]) off.add(f.id);
  return off;
}

/* Why this form cannot be queued yet, or null. */
function problem(def, form) {
  const off = disabledFields(def, form);
  for (const id of def.presets[form.preset ?? 0].requires ?? []) {
    if (!off.has(id) && words(form.values?.[id]).length === 0) return `Fill in “${def.fields.find((f) => f.id === id).label}”.`;
  }
  for (const f of def.fields ?? []) {
    if (f.type === 'set' && !off.has(f.id) && (form.values?.[f.id] ?? []).length === 0) return `Tick at least one of “${f.label}”.`;
  }
  return null;
}

function buildArgs(def, form) {
  const args = [...def.presets[form.preset ?? 0].args];
  const off = disabledFields(def, form);
  for (const f of def.fields ?? []) {
    if (off.has(f.id)) continue;
    const v = form.values?.[f.id];
    if (f.type === 'flag') { if (v) args.push(...f.args); }
    else if (f.type === 'set') {
      const unticked = f.options.map(([key]) => key).filter((key) => !v.includes(key));
      if (unticked.length) args.push(f.skipArg, unticked.join(','));
    } else if (f.type === 'text') {
      const w = words(v);
      if (!w.length) continue;
      if (f.repeat) w.forEach((word) => args.push(f.arg, word));
      else if (f.multi) args.push(f.arg, ...w);
      else args.push(f.arg, f.join ? w.join(f.join) : String(v).trim());
    } else if (v !== '' && v != null && String(v) !== String(f.dflt)) args.push(f.arg, String(v));
  }
  return args;
}

function fieldHtml(f, form) {
  const id = `fld-${f.id}`;
  const about = f.about ? `<span class="muted small block">${esc(f.about)}</span>` : '';
  const data = `data-field="${esc(f.id)}" id="${id}"`;
  const v = form.values[f.id];
  if (f.type === 'flag') return `<label data-for="${esc(f.id)}"><input type="checkbox" ${data} ${v ? 'checked' : ''}> ${esc(f.label)}${about}</label>`;
  if (f.type === 'set') {
    const boxes = f.options.map(([key, text]) => `<label class="inline"><input type="checkbox" data-set="${esc(f.id)}" value="${esc(key)}" ${v.includes(key) ? 'checked' : ''}> ${esc(text)}</label>`).join(' ');
    return `<div class="field" data-for="${esc(f.id)}"><div>${esc(f.label)}</div>${boxes}${about}</div>`;
  }
  const input = f.type === 'select'
    ? `<select ${data}>${f.options.map(([key, text]) => `<option value="${esc(key)}" ${key === v ? 'selected' : ''}>${esc(text)}</option>`).join('')}</select>`
    : f.type === 'number'
      ? `<input type="number" ${data} min="${f.min ?? 0}" value="${esc(v)}" placeholder="${esc(f.placeholder ?? '')}">`
      : `<input type="text" ${data} value="${esc(v)}" placeholder="${esc(f.placeholder ?? '')}" autocomplete="off" spellcheck="false">`;
  return `<label class="field" data-for="${esc(f.id)}">${esc(f.label)}${input}${about}</label>`;
}

function startFieldsHtml(def, form) {
  const presets = def.presets.map((p, i) => `<label><input type="radio" name="preset" value="${i}" ${i === (form.preset ?? 0) ? 'checked' : ''}> ${esc(p.label)}${p.about ? `<span class="muted small block">${esc(p.about)}</span>` : ''}</label>`).join('');
  return presets + (def.fields ?? []).map((f) => fieldHtml(f, form)).join('');
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
    const values = {};
    for (const f of def.fields ?? []) {
      if (f.type === 'set') values[f.id] = [...document.querySelectorAll(`input[data-set="${f.id}"]`)].filter((c) => c.checked).map((c) => c.value);
      else {
        const el = $(`fld-${f.id}`);
        values[f.id] = f.type === 'flag' ? el.checked : el.value;
      }
    }
    return { preset: Number(document.querySelector('input[name=preset]:checked')?.value ?? 0), values };
  }

  function refreshForm() {
    const def = START[startModule];
    const form = readForm();
    const off = disabledFields(def, form);
    document.querySelectorAll('#start-fields [data-for]').forEach((el) => {
      const dead = off.has(el.dataset.for);
      el.classList.toggle('disabled', dead);
      el.querySelectorAll('input, select').forEach((input) => { input.disabled = dead; });
    });
    $('start-preview').textContent = `hodow ${buildArgs(def, form).join(' ')}`;
    const why = problem(def, form);
    $('start-error').textContent = why ?? '';
    $('start-go').disabled = why != null;
  }

  function openStart(key) {
    startModule = key;
    const def = START[key];
    const module = state.modules.find((m) => m.key === key);
    $('start-title').innerHTML = `${esc(module.title)}${helpBtn(`module-${key}`, module.title)}`;
    $('start-fields').innerHTML = startFieldsHtml(def, initialForm(def));
    refreshForm();
    $('start-dialog').showModal();
  }

  $('start-form').addEventListener('input', refreshForm);
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
  module.exports = { esc, fmtDur, fmtMicros, recheckHtml, initialForm, disabledFields, problem, startFieldsHtml, whenOfId, statusChip, countChips, stepsHtml, visibleSteps, runHtml, liveHtml, queueHtml, modulesHtml, runsHtml,
    detailHtml, buildArgs, START, availabilityHtml, stepText, helpBtn, helpHtml, glossaryHtml, verdictLabel, TOPICS };
}
