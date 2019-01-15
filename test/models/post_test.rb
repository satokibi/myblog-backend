require 'test_helper'

class PostTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
    @post = Post.new( title: "test", body: "this is body.", published: true )
  end

  test "should be valid" do
    assert @post.valid?
  end

  test "title should be present" do
    @post.title = " "
    assert_not @post.valid?
  end

  test "body should be present" do
    @post.body = " "
    assert_not @post.valid?
  end
end
