pragma ComponentBehavior: Bound

import QtQuick.Layouts
import Caelestia.Config
import Caelestia.I18n
import qs.modules.nexus.common

PageBase {
    id: root

    function isToggleOn(id: string): bool {
        const item = Config.utilities.quickToggles.values.find(t => t.id === id);
        return item?.enabled ?? false;
    }

    function setToggleOn(id: string, on: bool): void {
        const list = GlobalConfig.utilities.quickToggles;
        for (let i = 0; i < list.count; i++) {
            const item = list.at(i);
            if (item.id === id) {
                item.enabled = on;
                return;
            }
        }
        list.insert({
            id,
            enabled: on
        });
    }

    title: Tr.tr("Utilities")
    isSubPage: true

    ColumnLayout {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top
        width: root.cappedWidth
        spacing: Tokens.spacing.extraSmall / 2

        // General
        SectionHeader {
            first: true
            text: Tr.tr("General")
        }

        ToggleRow {
            first: true
            last: true
            text: Tr.trCtx("Enabled", "toggle label")
            subtext: Tr.tr("Show the utilities panel")
            checked: Config.utilities.enabled
            onToggled: GlobalConfig.utilities.enabled = checked
        }

        // Cards
        SectionHeader {
            text: Tr.tr("Cards")
        }

        ToggleRow {
            first: true
            text: Tr.tr("Keep awake")
            subtext: Tr.tr("Show the idle inhibitor card")
            checked: Config.utilities.cards.keepAwake
            onToggled: GlobalConfig.utilities.cards.keepAwake = checked
        }

        ToggleRow {
            text: Tr.tr("Screen recorder")
            subtext: Tr.tr("Show the screen recorder card")
            checked: Config.utilities.cards.recorder
            onToggled: GlobalConfig.utilities.cards.recorder = checked
        }

        ToggleRow {
            last: true
            text: Tr.tr("Quick toggles")
            subtext: Tr.tr("Show the quick toggles card")
            checked: Config.utilities.cards.quickToggles
            onToggled: GlobalConfig.utilities.cards.quickToggles = checked
        }

        // Quick toggles
        SectionHeader {
            text: Tr.tr("Quick toggles")
        }

        ToggleRow {
            first: true
            text: Tr.tr("Wi-Fi")
            subtext: Tr.tr("Toggle wireless networking")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("wifi")
            onToggled: root.setToggleOn("wifi", checked)
        }

        ToggleRow {
            text: Tr.tr("Bluetooth")
            subtext: Tr.tr("Toggle the Bluetooth adapter")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("bluetooth")
            onToggled: root.setToggleOn("bluetooth", checked)
        }

        ToggleRow {
            text: Tr.tr("Microphone")
            subtext: Tr.tr("Mute or unmute the default source")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("mic")
            onToggled: root.setToggleOn("mic", checked)
        }

        ToggleRow {
            text: Tr.tr("Settings")
            subtext: Tr.tr("Open the settings window")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("settings")
            onToggled: root.setToggleOn("settings", checked)
        }

        ToggleRow {
            text: Tr.tr("Game mode")
            subtext: Tr.tr("Toggle game mode")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("gameMode")
            onToggled: root.setToggleOn("gameMode", checked)
        }

        ToggleRow {
            text: Tr.tr("Do not disturb")
            subtext: Tr.tr("Silence notifications")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("dnd")
            onToggled: root.setToggleOn("dnd", checked)
        }

        ToggleRow {
            last: true
            text: Tr.tr("VPN")
            subtext: Tr.tr("Connect or disconnect the VPN")
            disabled: !Config.utilities.cards.quickToggles
            checked: root.isToggleOn("vpn")
            onToggled: root.setToggleOn("vpn", checked)
        }

        // Game mode
        SectionHeader {
            text: Tr.tr("Game mode")
        }

        ToggleRow {
            first: true
            text: Tr.tr("Disable animations")
            subtext: Tr.tr("Turn off Hyprland animations")
            checked: GlobalConfig.utilities.gameMode.disableAnimations
            onToggled: GlobalConfig.utilities.gameMode.disableAnimations = checked
        }

        ToggleRow {
            text: Tr.tr("Disable shadows")
            subtext: Tr.tr("Turn off window shadows")
            checked: GlobalConfig.utilities.gameMode.disableShadows
            onToggled: GlobalConfig.utilities.gameMode.disableShadows = checked
        }

        ToggleRow {
            text: Tr.tr("Disable blur")
            subtext: Tr.tr("Turn off background blur")
            checked: GlobalConfig.utilities.gameMode.disableBlur
            onToggled: GlobalConfig.utilities.gameMode.disableBlur = checked
        }

        ToggleRow {
            text: Tr.tr("Remove gaps")
            subtext: Tr.tr("Remove gaps around windows")
            checked: GlobalConfig.utilities.gameMode.removeGaps
            onToggled: GlobalConfig.utilities.gameMode.removeGaps = checked
        }

        ToggleRow {
            text: Tr.tr("Remove rounding")
            subtext: Tr.tr("Square off window corners")
            checked: GlobalConfig.utilities.gameMode.removeRounding
            onToggled: GlobalConfig.utilities.gameMode.removeRounding = checked
        }

        ToggleRow {
            text: Tr.tr("Thin borders")
            subtext: Tr.tr("Set window borders to 1px")
            checked: GlobalConfig.utilities.gameMode.thinBorders
            onToggled: GlobalConfig.utilities.gameMode.thinBorders = checked
        }

        ToggleRow {
            last: true
            text: Tr.tr("Allow tearing")
            subtext: Tr.tr("Allow screen tearing for windows that request it")
            checked: GlobalConfig.utilities.gameMode.allowTearing
            onToggled: GlobalConfig.utilities.gameMode.allowTearing = checked
        }
    }
}
