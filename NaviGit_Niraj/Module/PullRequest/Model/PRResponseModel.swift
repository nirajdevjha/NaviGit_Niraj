//
//  PRResponseModel.swift
//  NaviGit_Niraj
//
//  Created by Niraj Jha on 26/09/22.
//

import Foundation

 struct PullRequest: Decodable {
     let title: String
     let createdAt: String?
     let closedAt: String?
     let user: UserInfo?
 }

 struct UserInfo: Decodable, Equatable {
     let login: String
     let avatarURL: String?
 }
