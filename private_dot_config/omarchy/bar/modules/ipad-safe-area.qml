import Quickshell
import QtQuick

Item {
  property var bar
  property string moduleName
  property var settings

  readonly property var hostWindow: QsWindow.window
  readonly property string hostOutput: hostWindow && hostWindow.screen ? hostWindow.screen.name : ""
  readonly property string targetOutput: settings && settings.output ? String(settings.output) : ""
  readonly property int span: settings && settings.size !== undefined ? Number(settings.size) : 24
  readonly property bool enabledForOutput: hostOutput === targetOutput

  implicitWidth: bar && bar.vertical ? bar.barSize : (enabledForOutput ? span : 0)
  implicitHeight: bar && bar.vertical ? (enabledForOutput ? span : 0) : (bar ? bar.barSize : 26)
  visible: enabledForOutput && span > 0
}
