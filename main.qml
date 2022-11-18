import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    property bool motorStatus: false
    width: 1200
    height: 500
    visible: true
    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"
        gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { id:bottomGradient; position: 0.0; color: "black" }
        }
    }
    Speedometer{
        id:speedometer
    }
    Tachometer{
        id: tachometer
        x: 600
        rpm:0
    }

    Text{
        id: motorStatusText
        color: "red"
        text: "Sammutettu"
        font.pointSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
    }

    Button{
        id:startButton
        buttonText: "Start"
        buttonColor: "lightgreen"
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        onButtonClicked: {
            if(motorStatus) {
                motorStatus = false
                startButton.buttonText = "start"
                startButton.buttonColor = "lightgreen"
                motorStatusText.text = "Sammutettu"
                motorStatusText.color = "red"
                tachometer.rpm -= 1000
                gasmeter.slowTurn = false
                gasmeter.gasoline = 0
                bottomGradient.position = 0.0
                bottomGradient.color = "black"
                buttonTextColor = "black"
            }

            else {
                motorStatus = true
                startButton.buttonText = "Stop"
                startButton.buttonColor = "black"
                motorStatusText.text = "Käynnissä"
                motorStatusText.color = "green"
                tachometer.rpm += 1000
                gasmeter.slowTurn = true
                gasmeter.gasoline = 1
                bottomGradient.position = 1.0
                bottomGradient.color = "red"
                buttonTextColor = "red"
            }
        }
    }

    Gasmeter{
        id:gasmeter
        x:425
        anchors.bottom: parent.bottom
    }
}
