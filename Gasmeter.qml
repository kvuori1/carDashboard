import QtQuick 2.15

Item {
    id:root
    property int gasoline: 250
    property bool slowTurn: false
    width: 250; height:250
    Image {
        id: gas
        width: 250; height:250
        source: "Assets/gas.png"
        property int jeesus: 0
        Image{
            id: needleOrange
            height: parent.height * 0.25
            source: "Assets/needleorange.png"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -0.5 * height
            rotation: -125 + gasoline
            transformOrigin: Item.Bottom
            Behavior on rotation {
                PropertyAnimation {
                    duration: durationCalc()
                }
            }
        }
    }

    function durationCalc() {
        if (slowTurn) {
            return 40   //aika millisekunneissa jaettuna 250, tankillinen kestää 10 sekuntia
        } else {
            return 1000
        }
    }
}
