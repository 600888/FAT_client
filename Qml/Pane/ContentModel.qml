import QtQuick 2.0
import QtQml 2.0
import QtQml.Models 2.1
ListModel {
    id: demoModel
    ListElement {
        name: "ChannelMonitoring"
        source: "General/Tables.qml"
        visible: true
        group: "RTDV_WIN"
        groupOpen: true
    }
    function updateSection(section, isOpen) {
        for (var i = 0; i < count; ++i) {
            var obj = get(i)
            if (obj["group"] === section) {
                setProperty(i, "groupOpen", isOpen)
            }
        }
    }
    function search(text) {
        var i = 0
        if (text.length <= 0) {
            for ( i = 0; i < count; ++i) {
                setProperty(i, "visible", true)
            }
        } else {
            var lowerText = String(text).toLowerCase()
            for (i = 0; i < count; ++i) {
                var obj = get(i)
                if (qsTr(obj["name"]).toLowerCase().indexOf(lowerText) >= 0) {
                    setProperty(i, "visible", true)
                } else {
                    setProperty(i, "visible", false)
                }
            }
        }
    }
    Component.onCompleted: {
        for (var i = 0; i < count; i++) {
            var obj = get(i)
            if (obj["name"] === "Shapes") {
                if(!hasShape) {
                    remove(i, 1)
                    break
                }
            }
        }
    }
}
