//
//  Repos.swift
//  POQProject
//
//  Created by Sorin Miroiu on 03.12.2023.
//

import Foundation

// MARK: - Repo
struct Repo: Codable, Identifiable {
    let id: Int
    let nodeID, name, fullName: String?
    let repoPrivate: Bool?
    let owner: RepoOwner?
    let htmlURL: String?
    let description: String?
    let fork: Bool?
    let url, forksURL: String?
    let keysURL, collaboratorsURL: String?
    let teamsURL, hooksURL: String?
    let issueEventsURL: String?
    let eventsURL: String?
    let assigneesURL, branchesURL: String?
    let tagsURL: String?
    let blobsURL, gitTagsURL, gitRefsURL, treesURL: String?
    let statusesURL: String?
    let languagesURL, stargazersURL, contributorsURL, subscribersURL: String?
    let subscriptionURL: String?
    let commitsURL, gitCommitsURL, commentsURL, issueCommentURL: String?
    let contentsURL, compareURL: String?
    let mergesURL: String?
    let archiveURL: String?
    let downloadsURL: String?
    let issuesURL, pullsURL, milestonesURL, notificationsURL: String?
    let labelsURL, releasesURL: String?
    let deploymentsURL: String?
    let createdAt, updatedAt, pushedAt: String?
    let gitURL, sshURL: String?
    let cloneURL: String?
    let svnURL: String?
    let homepage: String?
    let size, stargazersCount, watchersCount: Int?
    let language: String?
    let hasIssues, hasProjects, hasDownloads, hasWiki: Bool?
    let hasPages, hasDiscussions: Bool?
    let forksCount: Int?
    let mirrorURL: String?
    let archived, disabled: Bool?
    let openIssuesCount: Int?
    let license: RepoLicense?
    let allowForking, isTemplate, webCommitSignoffRequired: Bool?
    let topics: [String]?
    let visibility: String?
    let forks, openIssues, watchers: Int?
    let defaultBranch: String?
    let permissions: RepoPermissions?

    enum CodingKeys: String, CodingKey {
        case id
        case nodeID = "node_id"
        case name
        case fullName = "full_name"
        case repoPrivate = "private"
        case owner
        case htmlURL = "html_url"
        case description, fork, url
        case forksURL = "forks_url"
        case keysURL = "keys_url"
        case collaboratorsURL = "collaborators_url"
        case teamsURL = "teams_url"
        case hooksURL = "hooks_url"
        case issueEventsURL = "issue_events_url"
        case eventsURL = "events_url"
        case assigneesURL = "assignees_url"
        case branchesURL = "branches_url"
        case tagsURL = "tags_url"
        case blobsURL = "blobs_url"
        case gitTagsURL = "git_tags_url"
        case gitRefsURL = "git_refs_url"
        case treesURL = "trees_url"
        case statusesURL = "statuses_url"
        case languagesURL = "languages_url"
        case stargazersURL = "stargazers_url"
        case contributorsURL = "contributors_url"
        case subscribersURL = "subscribers_url"
        case subscriptionURL = "subscription_url"
        case commitsURL = "commits_url"
        case gitCommitsURL = "git_commits_url"
        case commentsURL = "comments_url"
        case issueCommentURL = "issue_comment_url"
        case contentsURL = "contents_url"
        case compareURL = "compare_url"
        case mergesURL = "merges_url"
        case archiveURL = "archive_url"
        case downloadsURL = "downloads_url"
        case issuesURL = "issues_url"
        case pullsURL = "pulls_url"
        case milestonesURL = "milestones_url"
        case notificationsURL = "notifications_url"
        case labelsURL = "labels_url"
        case releasesURL = "releases_url"
        case deploymentsURL = "deployments_url"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case gitURL = "git_url"
        case sshURL = "ssh_url"
        case cloneURL = "clone_url"
        case svnURL = "svn_url"
        case homepage, size
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language
        case hasIssues = "has_issues"
        case hasProjects = "has_projects"
        case hasDownloads = "has_downloads"
        case hasWiki = "has_wiki"
        case hasPages = "has_pages"
        case hasDiscussions = "has_discussions"
        case forksCount = "forks_count"
        case mirrorURL = "mirror_url"
        case archived, disabled
        case openIssuesCount = "open_issues_count"
        case license
        case allowForking = "allow_forking"
        case isTemplate = "is_template"
        case webCommitSignoffRequired = "web_commit_signoff_required"
        case topics, visibility, forks
        case openIssues = "open_issues"
        case watchers
        case defaultBranch = "default_branch"
        case permissions
    }
}

extension Repo: Hashable, Equatable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }

    static func == (lhs: Repo, rhs: Repo) -> Bool {
        lhs.id == rhs.id
    }

    static var dummy: Repo {
        Repo(id: 0, nodeID: nil, name: nil, fullName: nil,
             repoPrivate: nil, owner: nil, htmlURL: nil,
             description: nil, fork: nil, url: nil, forksURL: nil,
             keysURL: nil, collaboratorsURL: nil, teamsURL: nil,
             hooksURL: nil, issueEventsURL: nil, eventsURL: nil,
             assigneesURL: nil, branchesURL: nil, tagsURL: nil,
             blobsURL: nil, gitTagsURL: nil, gitRefsURL: nil,
             treesURL: nil, statusesURL: nil, languagesURL: nil,
             stargazersURL: nil, contributorsURL: nil, subscribersURL: nil,
             subscriptionURL: nil, commitsURL: nil, gitCommitsURL: nil,
             commentsURL: nil, issueCommentURL: nil, contentsURL: nil,
             compareURL: nil, mergesURL: nil, archiveURL: nil,
             downloadsURL: nil, issuesURL: nil, pullsURL: nil,
             milestonesURL: nil, notificationsURL: nil, labelsURL: nil,
             releasesURL: nil, deploymentsURL: nil, createdAt: nil,
             updatedAt: nil, pushedAt: nil, gitURL: nil, sshURL: nil,
             cloneURL: nil, svnURL: nil, homepage: nil, size: nil,
             stargazersCount: nil, watchersCount: nil, language: nil,
             hasIssues: nil, hasProjects: nil, hasDownloads: nil,
             hasWiki: nil, hasPages: nil, hasDiscussions: nil, forksCount: nil,
             mirrorURL: nil, archived: nil, disabled: nil, openIssuesCount: nil,
             license: nil, allowForking: nil, isTemplate: nil,
             webCommitSignoffRequired: nil, topics: nil, visibility: nil,
             forks: nil, openIssues: nil, watchers: nil,
             defaultBranch: nil, permissions: nil)
    }
}

// MARK: - RepoLicense
struct RepoLicense: Codable {
    let key, name, spdxID: String?
    let url: String?
    let nodeID: String?

    enum CodingKeys: String, CodingKey {
        case key, name
        case spdxID = "spdx_id"
        case url
        case nodeID = "node_id"
    }
}

// MARK: - RepoOwner
struct RepoOwner: Codable {
    let login: String?
    let id: Int?
    let nodeID: String?
    let avatarURL: String?
    let gravatarID: String?
    let url, htmlURL, followersURL: String?
    let followingURL, gistsURL, starredURL: String?
    let subscriptionsURL, organizationsURL, reposURL: String?
    let eventsURL: String?
    let receivedEventsURL: String?
    let type: String?
    let siteAdmin: Bool?

    enum CodingKeys: String, CodingKey {
        case login, id
        case nodeID = "node_id"
        case avatarURL = "avatar_url"
        case gravatarID = "gravatar_id"
        case url
        case htmlURL = "html_url"
        case followersURL = "followers_url"
        case followingURL = "following_url"
        case gistsURL = "gists_url"
        case starredURL = "starred_url"
        case subscriptionsURL = "subscriptions_url"
        case organizationsURL = "organizations_url"
        case reposURL = "repos_url"
        case eventsURL = "events_url"
        case receivedEventsURL = "received_events_url"
        case type
        case siteAdmin = "site_admin"
    }
}

// MARK: - RepoPermissions
struct RepoPermissions: Codable {
    let admin, maintain, push, triage: Bool?
    let pull: Bool?
}
