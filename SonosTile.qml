//
// Sonos app by Harmen Bartelink, further enhanced by Toonz
//

import QtQuick 1.1
import BasicUIControls 1.0
import qb.components 1.0

Tile {
	id: sonosTile

	onClicked: {
		if (app.mediaScreen)	
			app.mediaScreen.show();
	}
	

	//Show you the active zone name selected in the mediascreen.
	Text {
		id: zoneName

		text: app.sonosName
		font.pixelSize: isNxt ? 20 : 16
		font.family: qfont.regular.name
		font.bold: true

		wrapMode: Text.WordWrap
		horizontalAlignment: Text.AlignHCenter
		anchors {
			top: parent.top
			topMargin: 8
			horizontalCenter: parent.horizontalCenter
		}
		width: isNxt ? 250 : 200
		visible: !dimState
	}
	
	//Shows you the now playing image.
	StyledRectangle {
		id: nowPlaying
		width: nowPlayingImage.width+6
		height: nowPlayingImage.height+6
		radius: 3
		opacity: ((nowPlayingImage.height > 0)? 1.0:0.0)
		shadowPixelSize: 1
		anchors.top: zoneName.bottom
		anchors.left: parent.left
		anchors.leftMargin: 10
		anchors.topMargin: 5
		
		Image {
			id: nowPlayingImage
			source: app.nowPlayingImage
			width: isNxt ? 80 : 64
			height: ((sourceSize.height/sourceSize.width)*width) 
			anchors.top: parent.top
			anchors.left: parent.left
			anchors.leftMargin: 3
			anchors.topMargin: 3			
		}
		visible: !dimState && (app.nowPlayingImage.length > 5)
	}
	
	//shows you the now playing artist / number.
	Text {
		id: itemText

		text: app.actualArtist
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
		font.bold: true
		color: colors.clockTileColor
		wrapMode: Text.WordWrap
		anchors {
			top: zoneName.bottom
			topMargin: 10
			left: nowPlaying.right
			leftMargin: 10
		}
		width: isNxt ? 157 : 125
	}
	
	Text {
		id: titleText

		text: app.actualTitle
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
		font.bold: false
		color: colors.clockTileColor
		wrapMode: Text.WordWrap
		anchors {
			top: itemText.bottom
			topMargin: 5
			left: itemText.left
		}
		width: isNxt ? 157 : 125
	}

	
	Text {
		id: pauseText

		text: "(gepauzeerd)"
		font.pixelSize: isNxt ? 17 : 13
		font.family: qfont.regular.name
		font.bold: false
		color: colors.clockTileColor
		wrapMode: Text.WordWrap
		anchors {
			top: titleText.bottom
			topMargin: 5
			left: itemText.left
		}
		width: isNxt ? 157 : 125
		visible: dimState && app.playButtonVisible 
	}
	
	//volume control session start here, first you'll find the first button.
	IconButton {
		id: volumeDown
		anchors {
			bottom: parent.bottom
			bottomMargin: 5
			left: parent.left
			leftMargin: isNxt ? 2 : 1
		}

		iconSource: "./drawables/volume_down_small.png"
		onClicked: {
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/volume/-5");
		}
		visible: !dimState
	}
	IconButton {
		id: prevButton
		anchors {
			left: volumeDown.right
			leftMargin: isNxt ? 4 : 2
			bottom: volumeDown.bottom
		}

		iconSource: "./drawables/left.png"
		onClicked: {
			app.simpleSynchronous("http://"+app.connectionPath+"/previous");
		}
		visible: !dimState
	}

	IconButton {
		id: pauseButton
		anchors {
			left: prevButton.right
			leftMargin: isNxt ? 4 : 2
			bottom: prevButton.bottom
		}

		iconSource: "./drawables/pause.png"
		onClicked: {
			app.playButtonVisible = false;
			app.pauseButtonVisible = false;
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/pause");
		}
		visible: !dimState && app.pauseButtonVisible
	}
	
	IconButton {
		id: playButton
		anchors {
			left: prevButton.right
			leftMargin: isNxt ? 4 : 2
			bottom: pauseButton.bottom
		}

		iconSource: "./drawables/play.png"
		onClicked: {
			app.playButtonVisible = false;
			app.pauseButtonVisible = false;
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/play");
			}
		visible: !dimState && app.playButtonVisible
	}

	IconButton {
		id: shuffleOnButton
		anchors {
			left: playButton.right
			leftMargin: isNxt ? 4 : 2
			bottom: playButton.bottom
		}

		iconSource: "./drawables/shuffle_on.png"
		onClicked: {
			app.shuffleButtonVisible = false;
			app.shuffleOnButtonVisible = false;
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/shuffle/off");
		}
		visible: !dimState && app.shuffleButtonVisible
	}
	
	IconButton {
		id: shuffleButton
		anchors {
			left: playButton.right
			leftMargin: isNxt ? 4 : 2
			bottom: playButton.bottom
		}

		iconSource: "./drawables/shuffle.png"
		onClicked: {
			app.shuffleButtonVisible = false;
			app.shuffleOnButtonVisible = false;
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/shuffle/on");
		
		}
		visible: !dimState && app.shuffleOnButtonVisible
	}
	
	IconButton {
		id: nextButton
		anchors {
			left: shuffleButton.right
			leftMargin: isNxt ? 4 : 2
			bottom: shuffleButton.bottom
		}

		iconSource: "./drawables/right.png"
		onClicked: {
			console.log("next");
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/next");
		}
		visible: !dimState
	}	
	
	//last in this section is the volume up button.
	IconButton {
		id: volumeUp
		anchors {
			bottom: nextButton.bottom
			left: nextButton.right
			leftMargin: isNxt ? 4 : 2
		}

		iconSource: "./drawables/volume_up_small.png"
		onClicked: {
			app.simpleSynchronous("http://"+app.connectionPath+"/"+app.sonosName+"/volume/+5");
		}
		visible: !dimState
	}
}
