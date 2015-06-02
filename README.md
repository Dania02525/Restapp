# Phoenix Rest JSON API Example with JWT

Requires Erlang, Elixir and postgres

To test this out:

1. clone this repo
2. in the new folder, go to restapp/config/dev.exs and enter your postgres database, username, and password.  Also enter your preferred login username and password in config: :login.
3. in the new folder, go to restapp/config/test.exs and re-enter your postgres database, username, and password
4. cd to the folder, or just start a terminal in it
5. run mix deps.get && mix deps.compile to retrieve jwt libraries and compile.
6. run mix ecto.migrate --all
7. run mix compile (this compiles a formatter module which is outside of the /web directory and does not compile automagically)
8. run mix test (should have six passing tests)
9. run mix phoenix.server

#get regular user token
1. post your username and password to localhost:4000/login default is {"data":{"username":"user","password":"password"}}
2. copy token string
3. in request header for localhost:4000/api/invoices, add Token: (your user token)

#updating/adding to database with json
1. post json to the /api/invoices route in the format {"data":{"contact_id":"1"},"includes":[{"sell_price":"7.48"},{"sell_price":"5.32"}]} dont forget to add the regular user token to request header! 
You should recieve a 201 created status, and reloading get /invoices should show both the invoice and related invoice items.  If you forgot the token, or if you used the admin token instead, you will get a 401 error with 'incorrect audience' error.  
2. post json in the same format to /api/invoices/ (+ the id of the invoice just created).
You should recieve a 200 OK status, with changes applied to database
3. send request with method DELETE to /api/invoices/ (+ the id of the invoice just created) to delete record.

TODO:
test update, getone, and delete routes
integrate with simple Durandal SPA to demostrate how token can be used


Credits:
1. Thoughtbot rest api example
2. Phoenix and Elixir creators Chris Mccord and Jose Valim
3. Ecto creator, joken