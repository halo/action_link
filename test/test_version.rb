class TestVersion < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::ActionLink::VERSION
  end
end
