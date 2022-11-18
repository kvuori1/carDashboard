import QtQuick 2.15

Item {
    property int gasoline: 0
    property bool slowTurn: false
    width: 250; height:250
    Image {
        id: gas
        width: 250; height:250
        source: "Assets/gas.png"
        Image{
            id: needleOrange
            height: parent.height * 0.25
            source: "Assets/needleorange.png"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -0.5 * height
            rotation: 125 - gasoline * 250
            transformOrigin: Item.Bottom
            Behavior on rotation {
                PropertyAnimation {
                    function durationCalc() {
                        if (slowTurn) {
                            return 60000
                        } else {
                            return 1000
                        }
                    }
                    duration: durationCalc()

                }
            }
        }
    }
}
