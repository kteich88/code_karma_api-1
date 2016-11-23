# Show, Create, Update, Delete
class DeveloperProjectsController < ApplicationController
  include DeveloperProjectsHelper

  def show
    find_developer_by_user_id
    if verify_account_type
      show_my_projects
    else
      wrong_user_error
    end
  end

  def create
    new_dev_project
    if authorized_developer?
      save_dev_project
    else
      wrong_syntax_error
    end
  end

  def update
    find_dev_project_by_id
    if authorized_developer?
      edit_dev_project
    else
      wrong_user_error
    end
  end

  def destroy
    find_dev_project_by_id
    if authorized_developer?
      delete_dev_project
    else
      wrong_user_error
    end
  end

  def github_branches
    set_current_user
    find_dev_project_by_id
    calculate_client_branch_request_url
    client_branch_request_github
    calculate_developer_branch_request_url
    developer_branch_request_github
  end

  def commits
    find_dev_project_by_id
    set_current_user
    count_commits
  end

  def pull_request
    set_current_user
    find_dev_project_by_id
    if authorized_developer?
      capture_owner_repo
      pull_request_params
      octokit_pull_request
    else
      wrong_syntax_error
    end
  end
end
