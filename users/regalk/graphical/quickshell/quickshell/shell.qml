import "./modules/bar/"
import "./modules/overview/"

import Quickshell
import QtQuick

ShellRoot {
    property bool enableBar: true

    LazyLoader {
        active: enableBar
        component: Bar {}
    }
}
