import QtQuick 2.15
import QtQuick.Window 2.15

Window {
    property bool motorStatus: false
    property bool outOfGas: false
    property bool oilWarning: false
    property bool overheatWarning: false
    property bool motorWarning: false
    property bool blinkersOn: false
    property bool blinkersEmpty: true
    property int rand: 0

    width: 1200
    height: 500
    visible: true
    //Taustaväri
    Rectangle {
        id: background
        anchors.fill: parent
        color: "black"
        gradient: Gradient {
                GradientStop { position: 0.0; color: "black" }
                GradientStop { id:bottomGradient; position: 0.0; color: "black" }
        }
    }
    //Nopeusmittari
    Speedometer{
        id:speedometer
    }

    //Kierrosmittari
    Tachometer{
        id: tachometer
        x: 600
        rpm:0
    }

    //moottorin tila käyttäjälle
    Text{
        id: motorStatusText
        color: "red"
        text: "Sammutettu"
        font.pointSize: 24
        anchors.horizontalCenter: parent.horizontalCenter
    }

    //Löpölobbui teksti käyttäjälle
    Text{
        id:outOfGasText
        color: "red"
        text: "Löbö lobbu"
        font.pointSize: 24
        anchors.top: motorStatusText.bottom
        anchors.horizontalCenter: motorStatusText.horizontalCenter
        visible: false
    }

    //teksti kertoo mikä onglema autoon tuli
    Text{
        id:errorLight
        color: "red"
        text:""
        font.pointSize: 24
        anchors.top: outOfGasText.bottom
        anchors.horizontalCenter: motorStatusText.horizontalCenter
        visible: false
    }


    //Moottorin käynnistys nappi
    Item {
        id:startItem
        width:100; height:100
        anchors.right: parent.right
        anchors.bottom: parent.bottom
        Button{
            id:startButton
            buttonText: "Start"
            buttonColor: "lightgreen"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                if(!outOfGas && !oilWarning && !overheatWarning && !motorWarning) {
                    if(motorStatus ) {
                        //Sammutetaan moottori
                        motorStatus = false
                        startButton.buttonText = "start"
                        startButton.buttonColor = "lightgreen"
                        motorStatusText.text = "Sammutettu"
                        motorStatusText.color = "red"
                        tachometer.rpm = 0
                        fuelStateTimer.running = false
                        bottomGradient.position = 0.0
                        bottomGradient.color = "black"
                        buttonTextColor = "black"
                    }
                    else {
                        //pistetään moottori päälle
                        motorStatus = true
                        startButton.buttonText = "Stop"
                        startButton.buttonColor = "black"
                        motorStatusText.text = "Käynnissä"
                        motorStatusText.color = "green"
                        tachometer.rpm = 1000
                        gasmeter.slowTurn = true
                        fuelStateTimer.running = true
                        bottomGradient.position = 1.0
                        bottomGradient.color = "red"
                        buttonTextColor = "red"
                    }
                }
            }
        }
    }
    //pistetään kaikki napit itemien sisään, jotta muut napit eivät pompi kun yhtä pienennetään ja isonnetaan kun simuloidaan napin painamosta
    //tankkaus nappi
    Item {
        id: refuelItem
        width:100; height:100
        anchors.right: startItem.left
        anchors.bottom: parent.bottom
        Button{
            id:refuelButton
            buttonText: "Refuel"
            buttonColor: "lightgreen"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                outOfGas = false
                outOfGasText.visible = false
                gasmeter.slowTurn = false
                gasmeter.gasoline = 250
                outOfGasLight.visible = false
            }
        }
    }

    //korjaa öljy onglemat
    Item {
        id:fixOilItem
        width:100; height:100
        anchors.right: parent.right
        anchors.bottom: refuelItem.top
        Button {
            id:fixOilButton
            buttonText: "Tarkista öljyt"
            buttonColor: "lightgreen"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                if(oilWarning) {
                    oilLight.visible = false
                    errorLight.visible = false
                    errorLight.text = ""
                    oilWarning = false
                }
            }
        }
    }

    //katsotaan miksi kone on niin kuuma
    Item {
        id:fixOverHeatItem
        width:100; height:100
        anchors.right: parent.right
        anchors.bottom: fixOilItem.top
        Button {
            id:fixOverHeatButton
            buttonText: "Anna koneen \n jäähtyä"
            buttonColor: "lightgreen"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                if(overheatWarning) {
                    overHeat.visible = false
                    errorLight.visible = false
                    errorLight.text = ""
                    overheatWarning = false
                }
            }
        }
    }

    //korjataan moottori
    Item {
        id:fixMotorItem
        width:100; height:100
        anchors.right: parent.right
        anchors.bottom: fixOverHeatItem.top
        Button {
            id:fixmotorButton
            buttonText: "Korjaa moottori"
            buttonColor: "lightgreen"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                if(motorWarning) {
                    motorLight.visible = false
                    errorLight.visible = false
                    errorLight.text = ""
                    motorWarning = false
                }
            }
        }
    }

    //hätävilkut
    Item {
        id:blinkerItem
        width:100; height:100
        anchors.right: parent.right
        anchors.bottom: fixMotorItem.top
        Button{
            buttonText: "HätäVilkut"
            buttonColor: "orange"
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            onButtonClicked: {
                if(!blinkersOn) { //katsotaan onko jätävilkut päällä
                    blinkersOn = true
                } else {
                    blinkersOn = false
                    blinkersEmpty = true
                    blinkerEmpty.visible = true
                    blinkerFull.visible = false
                }
            }
        }
    }


    //hätävilkkujen ajastin
    Timer {
        id: blinkerTimer
        running: blinkersOn
        interval: 500
        repeat: true
        onTriggered: {
            if(blinkersEmpty) { // vaihedetaan kumpi näkyy, täysinäiset vai tyhjät vilkut
                blinkersEmpty = false
                blinkerEmpty.visible = false
                blinkerFull.visible = true
            } else {
                blinkersEmpty = true
                blinkerEmpty.visible = true
                blinkerFull.visible = false
            }
        }
    }

    //Päivitetään löpön tilaa ja arvotaan tuleeko vika valo
    Timer {
        id:fuelStateTimer
        interval: 40 //aika millisekunneissa jaettuna 250, tankillinen kestää 10 sekuntia
        running: false
        repeat: true
        onTriggered: {
            //katsotaan on bensaa jäljellä
            if(gasmeter.gasoline > 0) {
                gasmeter.gasoline -= 1
                rand = Math.random() * 616

                if(rand == 0) { //noin 33.38% mahdollisuus tulla per täysi tankki, että tulee vika
                    console.log()
                    fuelStateTimer.running = false
                    startButton.buttonClicked() //painetaan käynnistys nappulaa jotta saadaan moottori pois päältä ja päivitetty muut tilat
                    bigBroblem()    //arvotaan mikä ongelma tulee
                }

            } else { //jos bensa loppu päivitetään arvot
                fuelStateTimer.running = false
                startButton.buttonClicked() //painetaan käynnistys nappulaa jotta saadaan moottori pois päältä ja päivitetty muut tilat
                outOfGas = true
                outOfGasText.visible = true
                outOfGasLight.visible = true
            }
        }
    }






    //löoömittari
    Gasmeter{
        id:gasmeter
        x:425
        anchors.bottom: parent.bottom
    }

    //Tankki tyhjä valo
    OutOfGasLight{
        id: outOfGasLight
        visible: false
        x: 470; y: 200
    }

    //Öljyvika valo
    OilLight{
        id: oilLight
        visible: false
        x: 525; y: 200
    }

    //Ylikuumenemis valo
    OverHeatLight{
        id:overHeat
        visible: false
        x:470; y: 140

    }

    //Moottorin vika valo
    MotorLight{
        id:motorLight
        visible: false
        x: 530; y:140
    }

    //tyhjät vilkut
    BlinkerEmpty{
        id:blinkerEmpty
        visible: true
        x:440 ; y:70
    }

    //täysinäiset vilkut
    BlinkerFull{
        id:blinkerFull
        visible: false
        x:440 ; y:70
    }


    //arvotaan mikä ongelma tulee autoon
    function bigBroblem() {
        errorLight.visible = true
        rand = Math.random() * 3
        switch(rand) {
            case 0: {
                oilLight.visible = true
                oilWarning = true
                errorLight.text = "Öljy ongelma"
                break;
            }
            case 1: {
                overHeat.visible = true
                overheatWarning = true
                errorLight.text = "Kone on liian kuuma"
                break;
            }
            case 2: {
                motorLight.visible = true
                motorWarning = true
                errorLight.text = "Moottorissa vika"
                break;
            }
        }
    }
}
