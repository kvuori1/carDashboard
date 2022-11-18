import QtQuick 2.15

Rectangle{
    property string buttonText: ""
    property color buttonTextColor: "black"
    property color buttonColor: "lightgreen"
    signal buttonClicked
    color: buttonColor
    width:100; height:100
    radius: 50
    Text {
        text: parent.buttonText
        color: buttonTextColor
        anchors.centerIn: parent
    }
    MouseArea {
        anchors.fill: parent
        onPressed: {
            parent.width = 90
            parent.height = 90
        }
        onReleased: {
            parent.width = 100
            parent.height = 100
            parent.buttonClicked()
        }
    }
}
