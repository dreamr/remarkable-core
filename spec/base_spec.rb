require File.dirname(__FILE__) + '/spec_helper'

describe Remarkable::Base do

  before(:each) do
    @matcher = Remarkable::Specs::Matchers::ContainMatcher.new(1, 2, 3)
  end

  it 'should be set to negative' do
    @matcher.send(:positive?).should be_true
    @matcher.send(:negative?).should be_false

    @matcher.negative

    @matcher.send(:positive?).should be_false
    @matcher.send(:negative?).should be_true
  end

  it 'should store spec binding' do
    @matcher.spec(:binding)
    @matcher.instance_variable_get('@spec').should == :binding
  end

  it 'should provide a description' do
    @matcher.description.should == 'contain the given values'
  end

  it 'should provide a expectation' do
    @matcher.matches?([4])
    @matcher.expectation.should == 'the given values are included in [4] which is a Array'
  end

  it 'should provide a failure message' do
    @matcher.matches?([4])
    @matcher.failure_message.should == 'Expected the given values are included in [4] which is a Array (1 is not included in [4])'
  end

  it 'should provide a negative failure message' do
    @matcher.negative.matches?([1])
    @matcher.negative_failure_message.should == 'Did not expect the given values are included in [1] which is a Array'
  end

  it 'should provide default structure to matchers' do
    [1, 2, 3].should contain(1)
    [1, 2, 3].should contain(1, 2)
    [1, 2, 3].should contain(1, 2, 3)

    [1, 2, 3].should_not contain(4)
    [1, 2, 3].should_not contain(1, 4)
  end

  it { [1, 2, 3].should contain(1) }
  it { [1, 2, 3].should_not contain(10) }
end
