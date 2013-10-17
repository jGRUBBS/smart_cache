require "spec_helper"

describe SmartCache::Cache do
  
  before(:each) do
    @smart_cache = SmartCache::Cache.new
  end

  context "fetch" do

    it "should execute block when cache value not available" do
      result = @smart_cache.fetch("asdf", expires_in: 24.hours) do
        "this is a value"
      end

      result = @smart_cache.fetch("asdf", expires_in: 24.hours) do
        "another value"
      end
      
      result.should == "this is a value"
      result.should_not == "another value"     
    end

  end

end