import QtQuick 2.15

Item {
    property int kmh: 0
    Image {
        id: speedo
        width: 500; height:500
        source: "Assets/speedo.png"
        Image{
            id: needleBlue
            height: parent.height * 0.4
            source: "Assets/needleblue.png"
            anchors.centerIn: parent
            anchors.verticalCenterOffset: -0.5 * height
            rotation: -135
            transformOrigin: Item.Bottom
        }
    }
}
