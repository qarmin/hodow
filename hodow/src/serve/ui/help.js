'use strict';

/* What every word on the page means. Prose lives here so it can be edited without touching the logic.
   `short` is the tooltip, `body` is trusted HTML written below (never built from data), `related` are other topics. */
const HELP = {
  overview: {
    group: 'Start here',
    title: 'How to read this page',
    short: 'What this page is for',
    body: `<p><strong>hodow</strong> runs programs on this machine that use its processor, graphics driver and memory in specific ways, and checks that every result is what it should be. It is meant to tell <em>hardware and driver</em> problems from <em>software</em> ones: if a test gets a wrong answer, the machine is suspect, not the test.</p>
      <p>The page has four parts:</p>
      <ul>
        <li><strong>Checks</strong>: one card for each kind of test, what this machine can do, and the last result. Press <em>Run…</em> to queue one.</li>
        <li><strong>Running now</strong>: the job that is running, step by step, as it runs.</li>
        <li><strong>Queue</strong>: jobs waiting for their turn. One job runs at a time.</li>
        <li><strong>Runs</strong>: everything that was run on this machine, newest first. Click one to read every result.</li>
      </ul>
      <p>Every run is written to disk while it runs, so the results are there even if nobody was watching, and even if the machine had to be power-cycled. Anything with a small <span class="info-sample">i</span> next to it, and every coloured label, can be pressed to explain itself.</p>`,
    related: ['verdicts', 'statuses', 'steps', 'runs', 'security'],
  },

  /* ---- results ---- */
  verdicts: {
    group: 'Reading results',
    title: 'Results of a single test',
    short: 'The eight things a test can come out as',
    body: `<p>Each test ends as exactly one of these. The label on a run (<em>passed</em>, <em>failed</em>, …) is derived from them, see <em>Run status</em>.</p>
      <ul>
        <li><strong>passed</strong>: it ran and the result was checked and correct.</li>
        <li><strong>unverified</strong>: it ran, nothing crashed, but its result was compared with nothing.</li>
        <li><strong>skipped</strong>: it did not execute.</li>
        <li><strong>not supported</strong>: the driver or device does not offer what the test needs.</li>
        <li><strong>failed</strong>: it ran and the result was wrong.</li>
        <li><strong>panicked</strong>: the test's own code gave up (an assertion).</li>
        <li><strong>timed out</strong>: it never answered.</li>
        <li><strong>crashed</strong>: the process running it died.</li>
      </ul>
      <p>Press any of the coloured labels on the page for the details. <em>Passed</em> is the only one that says something good about the machine; always read it together with the others.</p>`,
    related: ['verdict-passed', 'verdict-unverified', 'verdict-skipped', 'verdict-not_supported', 'verdict-failed', 'verdict-crashed'],
  },
  'verdict-total': {
    group: 'Reading results',
    title: 'Tests',
    short: 'How many results were recorded',
    body: `<p>The number of individual results in this run. A single check can be tens of thousands of tests: the CPU suite has one per instruction and argument set.</p>
      <p>The coloured labels next to it split that number up; they add up to it. A label that is zero is not shown.</p>`,
    related: ['verdicts'],
  },
  'verdict-passed': {
    group: 'Reading results',
    title: 'Passed',
    short: 'Ran, and the result was checked and correct',
    body: `<p>The test ran and its result was compared with a value it must have, and they matched. What the value comes from depends on the check:</p>
      <ul>
        <li><strong>CPU instructions</strong>: a value that was captured earlier on real hardware.</li>
        <li><strong>OpenGL, Vulkan, burn-in, GPU memory</strong>: a value worked out by the test itself (for example a buffer where element <code>i</code> must be <code>i*3+7</code>), so it does not depend on any driver.</li>
        <li><strong>Benchmarks</strong>: the output matched one plain CPU reference, bit for bit for integer kernels.</li>
        <li><strong>Conformance suites</strong>: the case passed as the Khronos suite defines it.</li>
      </ul>
      <p>A pass is a statement about <em>this</em> test only. Many passes next to many <em>not supported</em> or <em>unverified</em> results mean much less than they look like.</p>`,
    related: ['verdict-unverified', 'verdict-not_supported'],
  },
  'verdict-unverified': {
    group: 'Reading results',
    title: 'Unverified',
    short: 'Ran without crashing, but its result was compared with nothing',
    body: `<p>The test ran the instruction or call, and nothing went wrong, but there was <strong>nothing to compare its result with</strong>. It is neither a pass nor a failure, and it does not turn a run red.</p>
      <p><strong>Why it exists.</strong> Counting these as passes would make a run look clean while saying only that nothing crashed. They are counted separately so the number is honest.</p>
      <p><strong>The usual reasons:</strong></p>
      <ul>
        <li>For a CPU instruction: no expected value has been captured on real hardware for it yet. The value this machine produced is shown next to the test (<code>= 0x…</code>); it can be captured on a machine known to be good and becomes a real check from then on.</li>
        <li>Some tests have nothing that could ever be checked: they return nothing, or something that is different on every machine (a CPU identification register, a hardware random number).</li>
      </ul>
      <p><strong>What to do.</strong> Nothing, for a normal run. If <em>every</em> test of an extension is unverified, that extension has not been verified on any hardware yet, so a clean run says little about it.</p>`,
    related: ['verdict-passed', 'verdict-skipped'],
  },
  'verdict-skipped': {
    group: 'Reading results',
    title: 'Skipped',
    short: 'Did not execute',
    body: `<p>The test did not run. The reason depends on how the check was run:</p>
      <ul>
        <li><strong>One result per test</strong> (isolated runs): the test looked at this machine, found it lacks something it needs (for example an instruction that needs a second CPU feature on top of its own), and returned before executing anything. The reason is shown next to it.</li>
        <li><strong>Plain runs</strong>: the number counts the tests that were not run: left out by a filter, or belonging to an extension this processor does not have. A computer without AVX-512 skips every AVX-512 test, which is expected.</li>
        <li><strong>Burn-in</strong>: a sub-test that cannot run here (no GPU, for example).</li>
      </ul>
      <p>Skipped says nothing about the machine, good or bad.</p>`,
    related: ['verdict-not_supported', 'verdict-unverified'],
  },
  'verdict-not_supported': {
    group: 'Reading results',
    title: 'Not supported',
    short: 'The driver or device does not offer what the test needs',
    body: `<p>The test needs something the graphics driver or device does not provide: an OpenGL function that could not be loaded, a Vulkan feature that is missing, a texture format it refuses. This is normal and not a failure; a software renderer or an embedded GPU lacks many things.</p>
      <p><strong>Always read it next to the passes.</strong> A run where most tests are <em>not supported</em> and the rest passed has mostly tested nothing. The conformance suites report this count on purpose for the same reason.</p>`,
    related: ['verdict-passed', 'availability'],
  },
  'verdict-failed': {
    group: 'Reading results',
    title: 'Failed',
    short: 'Ran, and the result was wrong',
    body: `<p>The test ran to the end and the result was not the one it must be, or it left an API error pending. The detail next to it says what was expected and what was seen.</p>
      <p>This is the verdict the project exists to find. A failure that appears only on some CPU cores, only under load, or only sometimes points at hardware (a faulty core, heat, voltage); one that appears every time on every core is more likely a systematic problem in the driver or in the test.</p>`,
    related: ['verdict-crashed', 'check-stress'],
  },
  'verdict-panicked': {
    group: 'Reading results',
    title: 'Panicked',
    short: 'The test code itself gave up',
    body: `<p>The test's own code stopped with an assertion or an unexpected state, but the process survived. It is counted with the failures. The message says where.</p>`,
    related: ['verdict-failed'],
  },
  'verdict-timed_out': {
    group: 'Reading results',
    title: 'Timed out',
    short: 'No answer within the time limit',
    body: `<p>The test did not finish in time and was stopped. The default limits are 10 seconds per CPU test and 30 seconds per OpenGL test in an isolated run, 60 seconds without progress per conformance case, 30 seconds for a burn-in sub-test and 60 seconds for a benchmark row. Each can be changed in the window that starts the check.</p>
      <p>A hang is a finding in itself: an instruction or a driver call that never returns is exactly the kind of fault this tool looks for. Only that one test is lost; the run goes on.</p>`,
    related: ['verdict-crashed'],
  },
  'verdict-crashed': {
    group: 'Reading results',
    title: 'Crashed',
    short: 'The process running the test died',
    body: `<p>The process that was running the test was killed by the system. In an isolated run every test (or a small group) runs in a child process, so a crash is blamed on that one test and the run continues. The detail names the signal:</p>
      <ul>
        <li><strong>SIGILL</strong>: illegal instruction. The CPU does not have it, or it is disabled.</li>
        <li><strong>SIGSEGV / SIGBUS</strong>: a bad or misaligned memory address.</li>
        <li><strong>SIGFPE</strong>: an arithmetic fault.</li>
        <li><strong>SIGKILL</strong>: usually the system's out-of-memory killer, not the test.</li>
        <li><strong>SIGABRT / SIGTRAP</strong>: the program or a driver aborted itself.</li>
      </ul>
      <p>A crash makes a run <em>crashed</em>, which is worse than <em>failed</em>.</p>`,
    related: ['verdict-failed', 'statuses'],
  },
  statuses: {
    group: 'Reading results',
    title: 'Run status',
    short: 'How a whole run ended',
    body: `<p>The label on a run, worked out from its results:</p>
      <ul>
        <li><strong>running</strong>: still going.</li>
        <li><strong>passed</strong>: nothing failed, panicked, timed out or crashed. It can still contain <em>unverified</em>, <em>skipped</em> and <em>not supported</em> tests; read the counts.</li>
        <li><strong>failed</strong>: at least one test failed, panicked or timed out.</li>
        <li><strong>crashed</strong>: at least one test crashed (this wins over failed).</li>
        <li><strong>interrupted</strong>: the run stopped without finishing: the program was killed, or the machine lost power. Everything recorded up to that point is kept. A run that shows no sign of life for an hour is also shown as interrupted.</li>
        <li><strong>cancelled</strong>: it was stopped on purpose, from this page or with Ctrl-C.</li>
        <li><strong>nothing to test</strong>: there was no driver for anything that was asked for. That is not a failure.</li>
      </ul>`,
    related: ['verdicts'],
  },
  'status-running': { group: 'Reading results', title: 'Running', short: 'Still going', body: '<p>This run has not finished. Its progress is shown under <em>Running now</em>.</p>', related: ['steps'] },
  'status-succeeded': { group: 'Reading results', title: 'Passed (run)', short: 'No failures, panics, timeouts or crashes', body: '<p>Nothing failed, panicked, timed out or crashed. The run can still contain unverified, skipped and not supported tests: read the counts next to it.</p>', related: ['statuses', 'verdict-unverified'] },
  'status-failed': { group: 'Reading results', title: 'Failed (run)', short: 'At least one test failed', body: '<p>At least one test failed, panicked or timed out. Open the run to see which.</p>', related: ['verdict-failed'] },
  'status-crashed': { group: 'Reading results', title: 'Crashed (run)', short: 'At least one test crashed', body: '<p>At least one test took its process down. Open the run to see which test and why.</p>', related: ['verdict-crashed'] },
  'status-interrupted': { group: 'Reading results', title: 'Interrupted', short: 'Stopped without finishing', body: '<p>The run did not finish: the program was killed, or the machine lost power or was rebooted. Everything recorded up to then is kept and can be read. A run that has shown no sign of life for an hour is also shown this way.</p>', related: ['statuses'] },
  'status-cancelled': { group: 'Reading results', title: 'Cancelled', short: 'Stopped on purpose', body: '<p>Someone pressed <em>Stop</em> on this page or Ctrl-C in a terminal. What was recorded up to then is kept.</p>', related: ['statuses'] },
  'status-skipped': { group: 'Reading results', title: 'Nothing to test', short: 'No driver for anything that was asked for', body: '<p>The check needs a driver that is not on this machine (no Vulkan loader, no OpenGL context). Nothing was run. This is not a failure.</p>', related: ['availability'] },
  'status-queued': { group: 'Reading results', title: 'Queued', short: 'Waiting for its turn', body: '<p>Jobs run one at a time, in the order they were queued.</p>', related: ['queue'] },
  'status-cancelled-job': { group: 'Reading results', title: 'Cancelled', short: 'Stopped on purpose', body: '<p>This job was removed from the queue or stopped.</p>', related: ['queue'] },

  /* ---- page ---- */
  steps: {
    group: 'The page',
    title: 'Progress, step by step',
    short: 'How to read the bars',
    body: `<p>A job is shown as a tree of steps. Each step has its own bar, because a long job is made of parts that are measured differently:</p>
      <ul>
        <li><code>302/4120 tests · 7% · ~2m left</code>: how many of how many, the percentage, and the time that is probably left. The time appears after a few seconds, once there is a speed to base it on; it is a guess and moves around.</li>
        <li><strong>A bar that slides back and forth</strong> means the total is not known (yet). Only the count so far is shown. It is never shown as 100% before the step is really finished.</li>
        <li><strong>Steps in seconds</strong> (burn-in, stress) show the time left exactly, since their length is fixed.</li>
        <li>The line under a running step is the thing that is being tested right now.</li>
        <li>Finished steps are ticked (✓) or crossed (✗). A long run has hundreds of steps, so only the ones running and the last few finished are shown.</li>
      </ul>
      <p>The coloured labels above the steps are the results so far; the list below them shows the latest ones that were not plain passes.</p>`,
    related: ['verdicts'],
  },
  queue: {
    group: 'The page',
    title: 'Queue',
    short: 'Jobs waiting for their turn',
    body: `<p>Checks use the processor, the GPU and the memory as hard as they can, so they would disturb each other: <strong>one job runs at a time</strong>, the rest wait here in the order they were queued. <em>Remove</em> takes a waiting job out; <em>Stop</em> on the running one ends it (the work done so far is kept as a cancelled run).</p>
      <p>Jobs can also be queued from another computer with <code>hodow --submit-to http://&lt;this machine&gt;:7878 test cpu</code>.</p>`,
    related: ['security'],
  },
  runs: {
    group: 'The page',
    title: 'Runs',
    short: 'Everything that was run on this machine',
    body: `<p>Every run, newest first, whether it was started here or in a terminal. Click one to read all of its results: filter by outcome, search by name, page through, open the files it produced (benchmark reports, for example).</p>
      <p>Runs are kept in a folder on this machine (its path is shown next to the heading). The folder is trimmed to <strong>5 GiB</strong> after each run, oldest first. A run that is still going, a <em>pinned</em> run and the latest run of each check are never removed.</p>
      <p>The same list is available in a terminal: <code>hodow runs</code>.</p>`,
    related: ['pin', 'filter'],
  },
  pin: {
    group: 'The page',
    title: 'Pinning',
    short: 'Keep a run when old ones are removed',
    body: `<p>The results folder has a size limit, and when it is exceeded the oldest runs are deleted. A <strong>pinned</strong> run is never deleted automatically. Pin the run of a good machine you want to compare against later, or the one that showed the problem. <em>Delete</em> removes a run for good, and is refused for a pinned or a running one.</p>`,
    related: ['runs'],
  },
  filter: {
    group: 'The page',
    title: 'Which results are listed',
    short: 'What the Show box filters',
    body: `<p><strong>everything except passed</strong> (the default) lists every result that is not a plain pass: failures, crashes, timeouts, panics, unverified, skipped and not supported. A run can have tens of thousands of tests; these are the ones worth reading. <strong>all</strong> lists every test. The others show one outcome only.</p>
      <p>The search matches part of the test name or of the detail text. For unverified tests the detail shows the value the machine produced (<code>= 0x…</code>).</p>`,
    related: ['verdicts'],
  },
  foreign: {
    group: 'The page',
    title: 'Started from a terminal',
    short: 'A run that is not a job of this page',
    body: `<p>Somebody ran <code>hodow test …</code> (or burn, bench) in a terminal on this machine. Its results are being written to the same folder, so it appears here. Its steps are shown as they start and finish; the fine-grained counters are only available for jobs started from this page.</p>`,
    related: ['steps', 'runs'],
  },
  availability: {
    group: 'The page',
    title: 'What this machine can do',
    short: 'Whether a check can run here',
    body: `<p>Shown on every card. For graphics, this is found out by a short separate program with a time limit, so a driver that hangs when started cannot take this page down.</p>
      <ul>
        <li><strong>available</strong>: it can run here (the devices it found are listed).</li>
        <li><strong>not available here</strong>: no driver or no device. Not a failure; the check simply has nothing to test on this machine.</li>
        <li><strong>check failed</strong>: asking the driver crashed or hung. That is itself worth looking into.</li>
        <li><strong>not built in</strong>: this copy of hodow was built without that part.</li>
        <li><strong>checking…</strong>: still being asked. <em>Check again</em> asks once more.</li>
      </ul>`,
    related: ['verdict-not_supported'],
  },
  security: {
    group: 'The page',
    title: 'Who can use this page',
    short: 'There is no password',
    body: `<p>This page has <strong>no login</strong>, on purpose: it is meant for a test bench, not the internet. Anyone who can reach its port can queue tests (only the supported checks, and only options that cannot write outside the results folder), stop jobs and read results.</p>
      <p>Started with <code>hodow serve --local</code> it listens on this machine only. Nothing on the page is loaded from the internet.</p>`,
    related: [],
  },

  /* ---- checks ---- */
  'module-cpu': {
    group: 'The checks',
    title: 'CPU instructions',
    short: 'Every SIMD instruction, checked against known results',
    body: `<p><strong>What it tests.</strong> The vector instructions of the processor (x86: SSE up to AVX-512; ARM: NEON, SVE) and the other special ones Rust can call. Tens of thousands of tests, each one an instruction called with several sets of arguments, including the awkward ones (largest, smallest, mixed signs). Only the instructions this processor reports having are run.</p>
      <p><strong>How a result is judged.</strong> Each result is compared with the value captured earlier on real hardware. Where no value was captured yet, the test only shows that the instruction runs: <em>unverified</em>.</p>
      <p><strong>Why.</strong> To find a processor, emulator, firmware or compiler that computes a wrong answer, or crashes on an instruction it claims to have.</p>
      <p><strong>Ways to run it.</strong></p>
      <ul>
        <li><em>Every test in its own process</em> (recommended): takes seconds to minutes. A crash or hang is blamed on that one test and the run goes on; you get one result per test.</li>
        <li><em>Plain run</em>: faster to start, but a crash ends everything and only per-extension counts are kept.</li>
        <li><em>Pipeline checks</em>: whole image pipelines (camera frame, GEMM, sort, histogram) checked bit for bit against one plain reference.</li>
      </ul>`,
    related: ['verdict-unverified', 'verdict-skipped', 'verdict-crashed', 'check-stress'],
  },
  'module-gl': {
    group: 'The checks',
    title: 'OpenGL',
    short: 'Graphics driver behaviour, function by function',
    body: `<p><strong>What it tests.</strong> The OpenGL (desktop and ES) functions the driver exposes, in groups by version: framebuffers, textures, shaders, uniform blocks, transform feedback, tessellation, compute, queries and more. Each test renders or computes something whose correct result is known without asking any driver, and reads it back.</p>
      <p><strong>What a result means.</strong> A function the driver does not offer makes the test <em>not supported</em>, not failed. A test that leaves an OpenGL error pending fails.</p>
      <p><strong>Ways to run it.</strong> <em>Headless</em> needs no display (it finds a graphics device by itself); <em>with a window</em> needs a desktop. <em>One process per test</em> means a driver crash or a hung GPU costs only that test. <em>Software rendering</em> forces the CPU renderer, useful to tell a driver bug from a test bug.</p>`,
    related: ['verdict-not_supported', 'availability', 'module-cts'],
  },
  'module-vulkan': {
    group: 'The checks',
    title: 'Vulkan compute',
    short: 'A compute shader with a known answer on every device',
    body: `<p><strong>What it tests.</strong> On each Vulkan device it finds, a small compute shader fills a buffer with a value that is known in advance (element <code>i</code> is <code>i*3+7</code>). The buffer is read back and compared bit for bit.</p>
      <p><strong>Why.</strong> A quick, driver-independent check that the device runs compute correctly, with nothing in it to blame but the device and its driver. For a thorough check use the Khronos conformance suite.</p>
      <p>If there is no Vulkan loader or driver, the run ends as <em>nothing to test</em>, which is not a failure.</p>`,
    related: ['availability', 'module-cts'],
  },
  'check-stress': {
    group: 'The checks',
    title: 'Why run the CPU tests under load?',
    short: 'A result that changes under load points at hardware',
    body: `<p>A wrong result that appears <em>only</em> on one core, or only after minutes of sustained load, points at hardware: a faulty core, heat or unstable voltage. Software bugs are repeatable.</p>
      <p>The stress check runs the whole CPU suite on every core at the same time and compares the results between cores. A failure on only <em>some</em> cores suggests a faulty core; a failure on <em>all</em> of them is more likely systematic (a test or a compiler issue).</p>`,
    related: ['module-stress', 'module-burn'],
  },
  'module-stress': {
    group: 'The checks',
    title: 'CPU stress',
    short: 'The whole suite on every core at once',
    body: `<p><strong>What it does.</strong> Starts one thread on each logical core and loops the whole CPU suite on all of them for the chosen number of seconds. Each thread reports how many rounds it finished and every wrong result. Instructions whose result is random by nature (the hardware random generator) are left out, since they would give false alarms.</p>
      <p><strong>Reading it.</strong> One result per core. A core that fails where the others do not is the suspect. Use it first for a few minutes; for hours of mixed load with temperatures use <em>Burn-in</em>.</p>
      <p>Unlike the isolated CPU check it runs inside one process, so a crash ends the stress run.</p>`,
    related: ['check-stress', 'module-burn'],
  },
  'module-burn': {
    group: 'The checks',
    title: 'Burn-in',
    short: 'CPU, RAM and GPU loaded as hard as possible, then together',
    body: `<p><strong>What it is for.</strong> A machine that is suspected of being <em>unstable</em> (random crashes, corrupted data, hangs under load) rather than one that runs a buggy driver.</p>
      <p><strong>What it does.</strong> In turn: the processor (the instruction suite on all cores, a maximum-power fused-multiply-add load, integer and cache traffic), the memory (the classic memory test patterns: stuck addresses, walking ones and zeros, moving inversions, block copies…), the GPU (its memory, arithmetic, rendering, creating contexts from several threads at once), and then all of them <em>together</em>, which is what brings out power and thermal trouble. Every sub-test checks its own answers, which are computed, never recorded.</p>
      <p><strong>Safety.</strong> Every sub-test runs in its own process, so a crash or a hang becomes that row's result instead of ending the run. The record is flushed to disk as it goes, so after a power cut it still says what was running. Temperatures are read where the system provides them, and a row shows the highest one.</p>
      <p><strong>How much memory.</strong> The memory phase takes <em>half of the memory that is available</em> (a container's limit counts), so the machine stays usable while it runs; <code>--ram-mb</code> asks for more. If the program may not lock memory (see <code>ulimit -l</code>) the test can be pushed to swap, so it then uses only memory that is free right now.</p>
      <p>The duration is the total for all phases (default 10 minutes; overnight runs are common). Not available on Windows.</p>`,
    related: ['check-stress', 'verdict-crashed', 'verdict-timed_out'],
  },
  'module-bench': {
    group: 'The checks',
    title: 'Benchmarks',
    short: 'Image kernels timed on the CPU and every GPU API',
    body: `<p><strong>What it measures.</strong> How long image-processing building blocks and whole pipelines (debayering, blurs, moments, copies, a camera pipeline) take, on the CPU (plain, auto-vectorised, hand-written SIMD) and on every GPU API found (OpenCL, OpenGL ES compute, Vulkan, TensorFlow Lite when present). A frame is timed from uploading to downloading, with the three parts shown separately for GPUs.</p>
      <p><strong>It is also a correctness check.</strong> Every row is compared with one plain CPU reference, bit for bit for integer kernels. A fast row with a wrong answer is a <em>failed</em> row, not a good one.</p>
      <p><strong>Sizes.</strong> <em>Quick</em> is a few minutes, <em>Default</em> longer, <em>Everything</em> an hour or more on a small board. Each run writes a report (HTML, Markdown, JSON); open it from the files list of the run.</p>
      <p>Rows run alone, since timings are only meaningful when nothing else is using the machine: do not start other jobs meanwhile. Not available on Windows.</p>`,
    related: ['runs'],
  },
  'module-gpu-memtest': {
    group: 'The checks',
    title: 'GPU memory',
    short: 'Bit patterns written to GPU memory and read back',
    body: `<p>Allocates a large buffer in graphics memory and, for several bit patterns, checks that (1) the data written and read back is identical, which tests the storage and both transfer paths, and (2) a compute shader can read, change and write every word correctly.</p>
      <p>Any difference is a bit error in GPU memory or in the path to it. The expected values follow from the pattern, so no driver is trusted. One result per pattern. Use the buffer size to cover most of the memory, but leave room for the system.</p>`,
    related: ['module-burn', 'availability'],
  },
  'module-cts': {
    group: 'The checks',
    title: 'Khronos conformance suites',
    short: 'The official conformance tests, case by case',
    body: `<p><strong>What it is.</strong> A Rust rewrite of the Khronos Conformance Test Suite, the official suite graphics drivers are certified with. The case names are identical to the original, so a result here can be compared with one from the original program on the same driver.</p>
      <p><strong>Groups.</strong> OpenGL ES 2.0, 3.0 and 3.1, desktop OpenGL (4.5 here), and Vulkan. Pick one; the Vulkan suite has hundreds of thousands of cases and runs for many hours. You can also name your own cases, for example <code>dEQP-VK.compute.*</code>, with <em>Only the cases I name below</em>.</p>
      <p><strong>Reading it.</strong> <em>Not supported</em> is common and not a failure, but report it next to the passes: a clean run with many unsupported cases proves little. A <em>crashed</em> or <em>timed out</em> case is a finding about the driver.</p>
      <p><strong>Very slow cases.</strong> A few cases (<code>flush_finish</code>) measure real time against the clock and can run for minutes on a slow or software driver, until the time limit kills them. They are skipped by default; untick <em>Skip the very slow cases</em> to run them anyway.</p>
      <p>Only available if this hodow was built with it, see the availability label on the card.</p>`,
    related: ['verdict-not_supported', 'availability'],
  },
};

if (typeof module !== 'undefined') module.exports = HELP;
