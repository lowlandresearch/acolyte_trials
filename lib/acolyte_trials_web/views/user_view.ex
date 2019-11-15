defmodule AcolyteTrialsWeb.UserView do
  use AcolyteTrialsWeb, :view

  def render("user.html", %{user: user}) do
    if user do
      ~E"""
        <strong><%= user.name %></strong> <small><%= "(#{user.github_username})" %></small>
      """
    else
      "None"
    end
  end
end
