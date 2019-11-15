defmodule AcolyteTrialsWeb.DeviceView do
  use AcolyteTrialsWeb, :view

  def user_select_options(users) do
    for user <- users, do: {"#{user.name} (#{user.github_username})", user.id}
  end
end
