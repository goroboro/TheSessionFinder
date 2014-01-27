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
        contentHeight: column.height

        Item {
            id: column
            anchors.fill: parent

            TextField {
                id: searchField
                placeholderText: "Search Tune"
                anchors.centerIn: page
                width: Screen.width - 20
                focus: true
            }

            Button {
                id: searchBtn
                anchors.top: searchField.bottom
                anchors.right: searchField.right
                text: "Search"
                onClicked: {
                    pageStack.push(Qt.resolvedUrl("Results.qml"), {
                                       queryString: searchField.text
                                   })
                }
            }
        }
    }
}
