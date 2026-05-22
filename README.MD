> ## 📦 This repo has moved
>
> The Quantum Device Workshop materials have moved to a dedicated, Dockerized
> repository:
>
> ### 👉 **[quantum-device-consortium/qdw26-workshop-materials](https://github.com/quantum-device-consortium/qdw26-workshop-materials)**
>
> The new repo wraps the same 4-notebook progression
> (`intro_to_layout`, `transmon_resonator`, `qubit_qubit_coupling`,
> `project`) in a shared `uv` + Docker environment, with JupyterLab /
> VS Code attach / Brev cloud-instance access paths. It also tracks the
> upgraded **Quantum Metal v0.7.x** API (lite-by-default install,
> `qm.view()` headless viewer, friendly missing-dependency errors). See
> the new repo's README for the full migration story.
>
> **This (old) repo will be archived** after the migration is verified.
>
> If you need the exact materials used at the QDW 2025 workshop, they
> are preserved at the tag
> **[`v2025-workshop`](https://github.com/zlatko-minev/tutorials_quantum_device_design/releases/tag/v2025-workshop)**
> — pinned to the pre-v0.5 Qiskit Metal era, `pyepr-quantum==0.8.5.7`,
> `pyaedt==0.6.46`. That tag is the canonical reference for the 2025
> workshop and won't change.
>
> *Original tutorial materials authored by **Murat Can Sarihan**, with
> content review by **Zlatko Minev**. Migration to maintained workshop
> infrastructure (Docker + uv + Brev) led by **Shanto Roy** (USC).*

---

# Simulating **Qiskit Metal** Designs with **palace** and **SQDMetal**

This tutorial explores the simulation of [Qiskit Metal](https://github.com/qiskit-community/qiskit-metal)  `design` objects using `palace`, facilitated by `SQDMetal`. The design of quantum devices, the foundation of the quantum ecosystem, is a multi-step process. Qiskit Metal endeavors to simplify and organize this undertaking.

**About Qiskit Metal**

[Qiskit Metal](https://github.com/qiskit-community/qiskit-metal) 
 \( [docs here](https://qiskit-community.github.io/qiskit-metal/index.html), [tutorials here](https://qiskit-community.github.io/qiskit-metal/tut/index.html)  \)  aims to provide a community-driven platform for quantum chip development, from concept to layout to electromagentics to Hamiltonians and to fabrication, within an open framework. It aims to foster innovation and make the design of quantum devices more accessible.  By automating and building in best practices, testing on real devices, Metal aims to make quantum hardware modeling more straightforward, reduce errors, and improve design speed.  It was started and led by Zlatko Minev, developed with the IBM Qiskit Metal team and many open-source contributors. It employs the permissive Apache 2.0 license and is now a community-maintained open-source package.

 The [Qiskit Metal tutorials](https://qiskit-community.github.io/qiskit-metal/tut/index.html) and [20+ videos on YouTube](https://www.youtube.com/playlist?list=PLOFEBzvs-VvqHl5ZqVmhB_FcSqmLufsjb) offer a good starting point for exploration.

**Contributing to the Future of Device Design**

The continued development of Qiskit Metal relies on its community. If you have an interest in quantum hardware and wish to contribute, consider becoming a maintainer or exploring funding opportunities. We invite you to the **Quantum Metal and device design session**. This will be a discussion with Zlatko Minev, Eli Levinson Falk, and other key figures in the Metal community about its future, the formation of a board of directors, and a maintainer group. If contributing to this effort interests you, we encourage you to connect at this workshop and **join the Thursday workshop on the future of Metal.** 


**What This Tutorial Covers**

Here, we will walk through electrostatic and eigenmode simulations of a qubit-cavity system. We will use `palace`, an open-source finite element analysis tool, through the `SQDMetal` interface. While Qiskit Metal also supports other tools like Elmer, this guide focuses on the `palace` integration.

We will learn to:
1.  Define a qubit-cavity system in Qiskit Metal.
2.  Prepare this design for simulation with `SQDMetal`.
3.  Run electrostatic simulations in `palace` to examine charge distributions and capacitances.
4.  Conduct eigenmode simulations in `palace` to find resonant frequencies and mode profiles.

This tutorial aims to provide a working knowledge of how these open-source tools can be combined for the analysis of superconducting quantum circuits, helping to reveal the underlying physics at play.

**Requirements:**

* [ ] Ensure that [`SQDMetal`](https://github.com/sqdlab/SQDMetal) is installed in your environment. This package includes installation of Qiskit Metal.
* [ ] Ensure that [`palace`](https://github.com/sqdlab/palace) is installed in your environment. Instructions are [here](https://lfl-lab.github.io/SQuADDS/source/resources/palace.html).

Let us begin the exploration.