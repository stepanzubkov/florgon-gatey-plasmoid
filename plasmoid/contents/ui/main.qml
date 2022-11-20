import QtQuick 2.0
import QtQuick.Layouts 1.1
import org.kde.plasma.plasmoid 2.0
import org.kde.plasma.core 2.0 as PlasmaCore

Item {

   Plasmoid.compactRepresentation: CompactRepresentation {}
   Plasmoid.fullRepresentation: FullRepresentation {}
   Plasmoid.preferredRepresentation: Plasmoid.compactRepresentation
	
} // end Item