
https://github.com/albertogeniola/meross-homeassistant/issues/607

Hi again,

Quick update: since no response here yet, I've continued maintaining the fork and just published a second release.

**Pull requests ported and released** (2.0.0-beta.1 and 2.0.0-beta.2):
- #587 – color-temp out-of-range fix, migrated to `ATTR_COLOR_TEMP_KELVIN` (thanks @ZakiZtraki)
- #591 – fix invalid `ColorMode.WHITE` on diffuser lights for HA 2026+ (thanks @Aldorus)
- #598 – catch `CommandTimeoutError` in `switch.py` `async_update` (thanks @CL0SeY)
- #606 – remove deprecated `CONNECTION_CLASS` config flow attribute (thanks @cerealkiller57540)
- #581 – expose device MAC address via `device_info` (thanks @doggkruse)

Also addressed #533 (device removal support).

The fork is available via HACS as a custom repository: https://github.com/blafoo/meross-homeassistant

**For anyone who wants to switch from this repo to the fork via HACS:**
1. In HACS, remove/uninstall the current "Meross Integration".
2. Delete the leftover `custom_components/meross_cloud` folder on your Home Assistant host (HACS keeps track of which repo "owns" a given integration folder and will refuse to overwrite it otherwise).
3. In HACS, add `https://github.com/blafoo/meross-homeassistant` as a custom repository (category: Integration).
4. Install "Meross Integration" again from the new source.
5. Restart Home Assistant.

Since the integration domain (`meross_cloud`) is unchanged, your existing config entries, devices and entities will keep working without any reconfiguration.

Still happy to hand maintenance back or collaborate if you're able to pick this up again — just let me know.
