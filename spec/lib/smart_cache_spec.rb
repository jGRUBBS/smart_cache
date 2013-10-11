require "spec_helper"

describe SmartCache::Cache do
  
  before(:each) do
    @smart_cache = SmartCache::Cache.new
  end

  context "fetch" do

    it "should execute block when cache value not available" do
      result = @smart_cache.fetch("asdf") do
        "this is a value"
      end
      
      result.should == "this is a value"      
    end

  end

end