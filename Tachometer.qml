import QtQuick 2.15

Item {
    property int rpm: 0
    Image {
        id: tacho
        width: 500; height:500
        source: "Assets/tacho.png"
        Image{
            id: needleRed
            height: parent.height * 0.4
            source: "Assets/needlered.png"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -0.5 * height
            rotation: -120 + rpm / 1000 * 30
            transformOrigin: Item.Bottom
            Behavior on rotation {
                PropertyAnimation {
                    duration: 1000
                }
            }
        }
    }
}
