# Curriculum Coverage

Exam: Cilium Certified Associate (CCA). Domain: Architecture (20%).

The [official objectives](https://training.linuxfoundation.org/certification/cilium-certified-associate-cca/) were checked on 2026-10-11. Teaching structure is independently authored and does not add official requirements.

| Section | Official objective | Modules |
| --- | --- | --- |
| 010 | Understand the Role of Cilium in Kubernetes Environments | 2 |
| 020 | Cilium Architecture | 2 |
| 030 | IP Address Management (IPAM) with Cilium | 3 |
| 040 | Cilium Component Roles | 3 |
| 050 | Datapath Models | 3 |

| Section / module | Module | Lab |
| --- | --- | --- |
| 010 / 01 | The Role Of Cilium In Kubernetes Networking | Record What Cilium Runs On The Cluster |
| 010 / 02 | Where Cilium Acts: Services, Pods And Policy | Separate Service Selection From Policy |
| 010 / cap | Capstone | Role Of Cilium Capstone |
| 020 / 01 | Security Identities In Cilium | Repair A Policy Through Pod Labels |
| 020 / 02 | Endpoints And The State Of The Datapath | Read Endpoint State From Cilium Objects |
| 020 / cap | Capstone | Cilium Architecture Capstone |
| 030 / 01 | IPAM Modes And Cluster Pool | Record The IPAM Mode And Pool Settings |
| 030 / 02 | From Node Range To Pod Address | Trace A Pod Address To Its Node Allocation |
| 030 / 03 | Multi-Pool IPAM | Select A Pod IP Pool For A Namespace |
| 030 / cap | Capstone | IPAM Capstone |
| 040 / 01 | The Cilium Agent | Change Agent Settings And Restart The Agents |
| 040 / 02 | The Operator And The CNI Plugin | Run The Operator In High Availability |
| 040 / 03 | Hubble And Hubble Relay | Restore Hubble Relay And Read Its Service |
| 040 / cap | Capstone | Component Roles Capstone |
| 050 / 01 | Overlay Routing | Record Overlay Routing Settings And Node Placement |
| 050 / 02 | Native Routing | Fix Native Routing Between Nodes |
| 050 / 03 | Comparing Datapath Models | Verify The Datapath Model Of A Cluster |
| 050 / cap | Capstone | Datapath Models Capstone |

Question banks are YAML files next to the sections and are listed in the manifest as quiz entries with a pass score of 70. Private playgrounds and graded labs are included. Live verification is recorded separately, and the labs are untested.

## Hands-On Coverage

This course has 13 ungraded playgrounds and 18 graded labs: one per module and one capstone per section. The labs are marked UNTESTED. They passed static checks (`astrona validate`, `bash -n` and a YAML parse) and have not been run.

| Section / module | Lab |
| --- | --- |
| 010 / 01 | Record What Cilium Runs On The Cluster |
| 010 / 02 | Separate Service Selection From Policy |
| 010 / cap | Role Of Cilium Capstone |
| 020 / 01 | Repair A Policy Through Pod Labels |
| 020 / 02 | Read Endpoint State From Cilium Objects |
| 020 / cap | Cilium Architecture Capstone |
| 030 / 01 | Record The IPAM Mode And Pool Settings |
| 030 / 02 | Trace A Pod Address To Its Node Allocation |
| 030 / 03 | Select A Pod IP Pool For A Namespace |
| 030 / cap | IPAM Capstone |
| 040 / 01 | Change Agent Settings And Restart The Agents |
| 040 / 02 | Run The Operator In High Availability |
| 040 / 03 | Restore Hubble Relay And Read Its Service |
| 040 / cap | Component Roles Capstone |
| 050 / 01 | Record Overlay Routing Settings And Node Placement |
| 050 / 02 | Fix Native Routing Between Nodes |
| 050 / 03 | Verify The Datapath Model Of A Cluster |
| 050 / cap | Datapath Models Capstone |
