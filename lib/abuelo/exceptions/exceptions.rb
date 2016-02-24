module Abuelo
  module Exceptions
    class NodeAlreadyExistsError < StandardError
    end

    class EdgeAlreadyExistsError < StandardError
    end

    class NoNodeError < StandardError
    end
  end
end
