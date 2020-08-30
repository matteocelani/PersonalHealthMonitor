//
//  VisitCell.swift
//  HealthMonitor
//
//  Created by Matteo Celani on 30/08/2020.
//  Copyright © 2020 Matteo Celani. All rights reserved.
//

import SwiftUI

struct VisitCell: View {
    
    let visit: Visit

    var body: some View {
        HStack {
            tagView

            VStack(alignment: .leading) {
                locationName
                visitDuration
            }

            Spacer()
        }
        .frame(height: VisitPreviewConstants.cellHeight)
        .padding(.vertical, VisitPreviewConstants.cellPadding)
    }

}

private extension VisitCell {

    var tagView: some View {
        RoundedRectangle(cornerRadius: 8)
            .fill(visit.tagColor)
            .frame(width: 5, height: 30)
    }

    var locationName: some View {
        Text(visit.locationName)
            .font(.system(size: 16))
            .lineLimit(1)
    }

    var visitDuration: some View {
        Text(visit.duration)
            .font(.system(size: 10))
            .lineLimit(1)
    }

}

struct VisitCell_Previews: PreviewProvider {
    static var previews: some View {
        DarkThemePreview {
            VisitCell(visit: .mock(withDate: Date()))
        }
    }
}
