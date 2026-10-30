import QtQuick
import Quickshell
import Quickshell.Io
import Caelestia
import Caelestia.Config
import Caelestia.I18n
import Caelestia.State
import qs.services

Scope {
    id: root

    readonly property var hyprOptions: {
        const cfg = GlobalConfig.utilities.gameMode;
        const opts = {};
        if (cfg.disableAnimations)
            opts["animations:enabled"] = 0;
        if (cfg.disableShadows)
            opts["decoration:shadow:enabled"] = 0;
        if (cfg.disableBlur)
            opts["decoration:blur:enabled"] = 0;
        if (cfg.removeGaps) {
            opts["general:gaps_in"] = 0;
            opts["general:gaps_out"] = 0;
        }
        if (cfg.thinBorders)
            opts["general:border_size"] = 1;
        if (cfg.removeRounding)
            opts["decoration:rounding"] = 0;
        if (cfg.allowTearing)
            opts["general:allow_tearing"] = 1;
        return Object.assign(opts, cfg.hyprOverrides);
    }

    function applyGameMode(): void {
        Hypr.extras.applyOptions(root.hyprOptions);
    }

    function syncState(enableDisable: bool): void {
        if (RuntimeState.gameMode) {
            root.applyGameMode();
            if (GlobalConfig.utilities.toasts.gameModeChanged)
                Toaster.toast(Tr.tr("Game mode enabled"), Tr.tr("Disabled Hyprland animations, blur, gaps and shadows"), "gamepad");
        } else if (enableDisable) {
            Hypr.extras.message("reload");
            if (GlobalConfig.utilities.toasts.gameModeChanged)
                Toaster.toast(Tr.tr("Game mode disabled"), Tr.tr("Hyprland settings restored"), "gamepad");
        }
    }

    // Reload to restore options that are no longer overridden; onConfigReloaded reapplies the rest
    onHyprOptionsChanged: {
        if (RuntimeState.gameMode)
            Hypr.extras.message("reload");
    }
    Component.onCompleted: syncState(false)

    Connections {
        function onGameModeChanged(): void {
            root.syncState(true);
        }

        target: RuntimeState
    }

    Connections {
        function onConfigReloaded(): void {
            if (RuntimeState.gameMode)
                root.applyGameMode();
        }

        target: Hypr
    }

    IpcHandler {
        function isEnabled(): bool {
            return RuntimeState.gameMode;
        }

        function toggle(): void {
            RuntimeState.gameMode = !RuntimeState.gameMode;
        }

        function enable(): void {
            RuntimeState.gameMode = true;
        }

        function disable(): void {
            RuntimeState.gameMode = false;
        }

        target: "gameMode"
    }
}
