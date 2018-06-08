defmodule Cowboy.Dispatch do
  def start do

    dispatch = :cowboy_router.compile([
      { :_,
        [
          {"/", Cowboy.RootPageHandler, []},
          {"/websocket", Cowboy.WsHandler, []},
          {"/[...]", :cowboy_static, { :priv_dir, :cowboy_app, "",[{:mimetypes,:cow_mimetypes,:all}]}}
        ]
      }
    ])
    {:ok, _} = :cowboy.start_http(:cowboy_app, 100, [{:port, 8080}],[{:env, [{:dispatch, dispatch}]}])

  end

end
