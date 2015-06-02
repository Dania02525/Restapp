defmodule Restapp.Formatter do

  def date(date) do
  	:io_lib.format("~4..0B-~2..0B-~2..0B", Tuple.to_list(date))
  	  |> List.flatten
  	  |> to_string
  end

  def numeric(number) do
  	(number.sign*number.coef)/:math.pow(10, -(number.exp))
  end

end