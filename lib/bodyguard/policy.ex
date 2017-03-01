defmodule Bodyguard.Policy do
  @moduledoc """
  Behaviour to authorize actions within a context.

  Implement this behaviour for each context that will be authorized. 
  The module naming convention is `MyApp.MyContext.Policy`.
  """

  @doc """
  Authorize a user's action.

  The `action` is whatever user-specified contextual action is being authorized.
  It bears no intrinsic mapping to a controller "action".

  To permit an action, return `true` or `:ok`.

  To deny authorization, return `false`, `:error`, or `{:error, reason}`.
  """
  @callback guard(user :: any, action :: atom, params :: map) :: boolean | :ok
      | :error | {:error, reason :: atom}

  @doc """
  Limit which resources a user can access.

  The `resource` is the module of the particular struct/schema/model that is being scoped.

  The `scope` argument is a broad specification of what to narrow down. 
  Typically it is an Ecto queryable, although it can also be a list of structs
  or any other custom data.

  The result should be a limited subset of the passed-in `scope`, or the `scope` itself
  if no limitations are required.
  """
  @callback limit(user :: term, resource :: module, scope :: any, params :: map) :: term
end