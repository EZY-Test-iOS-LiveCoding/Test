//
//  StepExt.swift
//  Test
//
//  Created by baegteun on 2021/11/13.
//

import RxFlow

extension Step{
    var asHanStep: HanStep?{
        return self as? HanStep
    }
}
