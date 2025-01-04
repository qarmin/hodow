# Documentation index

Where to look, by what you want to know.

| I want to... | Read |
|---|---|
| know what hodow is, run it, see what is covered | [`../README.md`](../README.md) |
| build, install, cross-compile, or build under a memory limit | [`building.md`](building.md) |
| fix a build failure, an OOM, a hang, a crash, "no driver" | [`troubleshooting.md`](troubleshooting.md) |
| understand the project layout and its rules (agents and contributors) | [`../CLAUDE.md`](../CLAUDE.md) |
| run, extend or debug the conformance suites | [`../hodow_cts/README.md`](../hodow_cts/README.md) |
| see what is known about upstream CTS and driver bugs | [`../hodow_cts/QUIRKS.md`](../hodow_cts/QUIRKS.md) |
| write an OpenGL test | [`../hodow_gpu/src/opengl/README.md`](../hodow_gpu/src/opengl/README.md) |
| use the helper scripts and generators | [`../scripts/README.md`](../scripts/README.md) |

Rules for these files: `README.md` is for users (short, with numbers), `CLAUDE.md` is for whoever develops the project (layout, principles, traps), everything else is reference. Numbers belong to the tool that measures them (`hodow dev coverage`, `just cts-coverage`), so a date next to a number in a document means it can be stale.
