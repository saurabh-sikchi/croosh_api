ActiveSupport::NumberHelper::NumberToHumanConverter::INVERTED_DECIMAL_UNITS.merge!(lakh: 5)

ActiveSupport::NumberHelper::NumberToHumanConverter::DECIMAL_UNITS.merge!(5 => :lakh)