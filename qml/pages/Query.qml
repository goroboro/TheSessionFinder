import QtQuick 2.0
import Sailfish.Silica 1.0

Page {
    id: page
    SilicaFlickable {
        anchors.fill: parent

        // PullDownMenu and PushUpMenu must be declared in SilicaFlickable, SilicaListView or SilicaGridView
        PullDownMenu {
            MenuItem {
                text: "Return To Collection"
                onClicked: {
                    pageStack.clear()
                    pageStack.push('CollectionPage.qml')
                }
            }
        }
        // Tell SilicaFlickable the height of its content.
        contentHeight: item.height

        Item {
            id: item
            anchors.fill: parent
            height: page.height

            TextField {
                id: searchField
                placeholderText: "Search Tune (e.g. Butterfly)"
                anchors.verticalCenter: parent.verticalCenter
                width: parent.width - 20
                focus: true
                Keys.onEnterPressed: {
                    pageStack.push(Qt.resolvedUrl("Results.qml"), {
                                       queryString: searchField.text
                                   })
                }
                Keys.onReturnPressed: {
                    pageStack.push(Qt.resolvedUrl("Results.qml"), {
                                       queryString: searchField.text
                                   })
                }
            }

            Button {
                id: searchBtn
                anchors.top: searchField.bottom
                anchors.horizontalCenter: parent.horizontalCenter
                text: "Search"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("Results.qml"), {
                                       queryString: searchField.text
                                   })
                }
            }



            TextArea {
                id: help
                anchors.top: searchBtn.bottom
                width: parent.width
                text: "Search for a traditional tune on thesession.org. For example, try searching for 'Off to California' or 'Dusty Windowsills'."
                font.pixelSize: Theme.fontSizeSmall
            }
        }
    }
}
