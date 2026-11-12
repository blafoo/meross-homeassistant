# 2.0.0-beta.4 (2026-11-12)
- Fix setup failing with `HttpSubdeviceInfo.__init__() missing 2 required positional arguments: 'true_id' and 'sub_device_vendor'` for accounts with a hub, caused by a breaking change in the Meross HTTP API: update `meross_iot` 0.4.9.2 → 0.4.10.4 and pass an HA-provided SSL context to the MQTT manager, since `mqtt_skip_cert_validation` was removed from the library (#1; ported from upstream, albertogeniola/meross-homeassistant#584 and #567).
- Add support for MTS150 thermostat valves, which previously only exposed a battery sensor: `meross_iot` has no class for the `mts150` sub-device type, so it is now registered with the `Mts100v3Valve` class (same `Appliance.Hub.Mts100.*` protocol), giving it climate controls and a temperature sensor (see albertogeniola/MerossIot#420, albertogeniola/meross-homeassistant#405).

# 2.0.0-beta.3 (2026-11-11)
- Fix `supported_color_modes` on `LightEntityWrapper`/`DiffuserLightEntityWrapper` combining `ColorMode.BRIGHTNESS` with `ColorMode.RGB`/`ColorMode.COLOR_TEMP`, which HA rejects as invalid and refuses to add the entity (affected e.g. the `msl320cpr` LED strip).
- Migrate `ValveEntityWrapper`/`ThermostatEntityWrapper` to the `native_temperature_unit`/`native_current_temperature`/`native_target_temperature` climate properties, fixing deprecation warnings (old properties are removed in HA 2027.11).
- Upgrade CI workflows (`actions/checkout` v4 → v5, `actions/stale` v8 → v10) to use the current Node runtime.
- Fix HACS/hassfest validation warnings: add `categories` to `manifest.json`, move `config.title` to the root of `strings.json`/translations.

# 2.0.0-beta.2 (2026-11-11)
- Fix invalid `ColorMode.WHITE` on diffuser lights, which HA 2026+ rejects outright, causing affected devices (e.g. MSS560x dimmers) to not be added at all; switched to `ColorMode.BRIGHTNESS` (originally proposed in albertogeniola/meross-homeassistant#591, thanks @Aldorus).
- Catch `CommandTimeoutError` in `SwitchEntityWrapper.async_update` so a transient network timeout while polling power/consumption metrics no longer breaks entity setup/polling (originally proposed in albertogeniola/meross-homeassistant#598, thanks @CL0SeY).
- Remove the deprecated `CONNECTION_CLASS`/`CONN_CLASS_CLOUD_PUSH` config flow attribute, which HA Core will remove in 2027.5.0 (originally proposed in albertogeniola/meross-homeassistant#606, thanks @cerealkiller57540).
- Expose each device's MAC address via `device_info.connections`, enabling cross-referencing with other integrations such as device trackers (originally proposed in albertogeniola/meross-homeassistant#581, thanks @doggkruse).

# 2.0.0-beta.1 (2026-11-10)
- Initial release after forking the project to a new maintainer. The component is now maintained by @blafoo. Thanks to @albertogeniola for the previous work and support.
- Fix color-temperature handling for Meross bulbs: migrate to `ATTR_COLOR_TEMP_KELVIN`, clamp out-of-range values and declare the supported Kelvin range, addressing "Out of range" errors (originally proposed in albertogeniola/meross-homeassistant#587, thanks @ZakiZtraki).
- Enable removal of stale/orphaned devices (no longer known to the Meross account) directly from the Home Assistant UI, addressing albertogeniola/meross-homeassistant#533.

# 1.3.10beta1 (2025-09-29)
- Update low-level dependency to 0.4.9.2, so to address #569
- Attempt to address #479

# 1.3.9 (2025-08-22)
- Address #563: let HA re-authenticate in case of expired token or password change

# 1.3.8 (2025-08-22)
- Address #552, #568 and similar.

# 1.3.7 (2025-06-18)
- Merge #555 to fix config_entries.async_forward_entry_setup deprecation (thanks @Easen!)

# 1.3.6 (2025-03-17)
- Updated meross_iot dependency to 0.4.9.0 which fixes issues with paho-mqtt
- Set Min HA version to 2025.3

# 1.3.5 & 1.3.4 - RETIRED

# 1.3.2beta1 (2024-05-04)
- Using MerossIot v0.4.7.2b3 which should add support for HomeKit Hubs (addressing #435 and possibly #400)
- Add support for BatteryLevel sensors for Meross SubDevices
- Address #499

# 1.3.1 (2024-04-28)
- Fix light platform deprecations
- Fix climate platform deprecations
- Add OPENING and CLOSING transient states for garage openers (#493)
- Change log verbosity from INFO to DEBUG (addresses #481)

# 1.3.1beta1 (2024-04-25)
- Implement MFA support (addressing #467)
- Avoid storing username/password credentials (addressing #486)

<!--next-version-placeholder-->
# 1.3.0 (2024-04-25)
- Add support for Meross OilDiffuser
- Refactor Meross Humidifier
- Update low level library to version 0.4.7.0
- Addressing #484 

# 1.2.12 (2024-01-27)
- Merge PR #449, fixing #448. Credits to @mguilherme

# 1.2.11 (2024-01-27)
- Using the latest API Endpoints from Meross, version 0.4.6.0
- Fix logging errors
- Fix deprecated constants usage

# 1.2.10 (2023-10-15)
- Using the latest API Endpoints from Meross
- Supporting energy sensor for plugs (#460, thanks to @benoitm974)
- Fixes component unloading issue (thanks to @TheHolyRoger)
- Attention: this version is not compatible with local-only addon

# 1.2.9b0 (2023-09-18)
- Update low-level library to v0.4.6.0rc2 to support new API endpoints
- Merged PR #447

# 1.2.8 (2022-01-05)
- Update low-level library to v0.4.5.7, addressing issue #414

# 1.2.7 (2023-01-04)
- Update low-level library to v0.4.5.4 to solve issue #412

# 1.2.6 (2022-07-27)
- Add roller shutter (MSR100) support
- Add thermostat (MTS200) support
- Implement support for LAN-LOCAL HTTP transport mode
- Update dependency to low-level meross_iot library (0.4.5.0)

# 1.2.5rc5 (2022-06-24)
- Fix log error caused by wrong variable reference

# 1.2.5rc (2022-06-23)
- Set addon to run on internal network
- Set default values for IP:PORT when using local addon and no mDNS info is gathered.

# 1.2.5rc3 (2022-06-23)
- Set addon to run on host network to make mDNS work
- Improve setup & UI experience

# 1.2.5rc2 (2022-06-18)

- Fix import error preventing the component from loading via HA

# 1.2.5rc1 (2022-06-18) - RETIRED

- Removed zeroconf HA discovery support as it is now managed via setup config flow.
- This component is now working with the [Meross Local Addon](https://github.com/albertogeniola/ha-meross-local-broker) (still in alpha, though).

# 1.2.5rc0 (2022-06-12)

- Merges 1.2.4-rc1 features with the latest master release (v1.2.4)  

# 1.2.4 (2022-06-12)

- Merges pull request #365 that fixes MSS3XX consumption readings

## 1.2.4-rc1 (2022-06-06)

### Feature

- Updated low-level library to MerossIot v0.4.4.7

## 1.2.4-rc0 (2022-06-05)

### Feature

- Updated low-level library to MerossIot v0.4.4.6

## 1.2.3 (2022-06-03)

### Feature

- Updated low-level library to MerossIot v0.4.4.5

## 1.2.2 (2022-05-29)

### Feature

- Prepared component for integration with the Meross local-addon
- Updated HACS badge URL (thanks to @wrt54g)

## 1.2.1 (2022-01-30)

### Feature

- Upgraded low-level library dependency to 0.4.4.4
- Added MSG200 Support  
- Updated default polling intervals: sensor polling every 30s, API discovery every 120s
- Added option to set a custom user-agent for HTTP communication against Meross API


## 1.2.0rc2 (2022-01-18)

### Feature

- Upgraded low-level library dependency to 0.4.4.3
- Improved HACS documentation
- Added .devcontainer and .vscode tasks to support local-debugging
