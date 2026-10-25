<p align="right">
  <img align="right" height="140" src="https://github.com/PureKFD/PureKFD/blob/v6/Icon.png?raw=true" alt="PureKFD Logo" style="float: right; border-radius: 10px;"/>
</p>

# Clover
> SideStore is an untethered alternative app store for non-jailbroken iOS devices

[![License: AGPL v3](https://img.shields.io/badge/License-AGPL%20v3-blue.svg)](https://www.gnu.org/licenses/agpl-3.0)
[![PRs Welcome](https://img.shields.io/badge/PRs-welcome-brightgreen.svg)](https://makeapullrequest.com)

![Alt](https://repobeats.axiom.co/api/embed/3a329ce95955690b9a9366f8d5598626a847d96c.svg "Repobeats analytics image")

Clover is an iOS application that allows you to sideload apps onto your iOS device with just your Apple ID. Resigns apps with your personal development certificate, and then uses a specially designed VPN in order to trick iOS into installing them

Clover’s goal is to provide an untethered sideloading experience. It’s an inspiration of SideStore and AltStore, made with love and passion 

## Requirements
- Xcode 27
- iOS 17
- Rustup (`brew install rustup`)

# Clover
SideStore is a just regular, sandboxed iOS application. The AltStore app target contains the vast majority of SideStore's functionality, including all the logic for downloading and updating apps through SideStore. SideStore makes heavy use of standard iOS frameworks and technologies most iOS developers are familiar with.
