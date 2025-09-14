import "./modules/bar/"

import Quickshell
import QtQuick

ShellRoot {
    property bool enableBar: true

    LazyLoader {
        active: enableBar
        component: Bar {}
    }
}
