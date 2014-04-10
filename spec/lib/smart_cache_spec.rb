require "spec_helper"

describe SmartCache::Cache do
  
  before(:each) do
    @smart_cache = SmartCache::Cache.new
  end

  context "fetch" do

    it "should execute block when cache value not available" do
      result = @smart_cache.fetch("asdf", expires_in: 24.hours) do
        "first value"
      end

      result = @smart_cache.fetch("asdf", expires_in: 24.hours) do
        "second value"
      end

      new_smart_cache = SmartCache::Cache.new
      result = new_smart_cache.fetch("asdf", expires_in: 24.hours) do
        "third value"
      end
      
      result.should == "first value"
      result.should_not == "second value"     
    end

    it "should enqueue job to replace cache when expiration is passed" do

      result = @smart_cache.fetch("asdf", expires_in: 1.hour) do
        "first value"
      end

      result.should == "first value"

      Timecop.freeze(Time.now + 2.hours) do
        result = @smart_cache.fetch("asdf", expires_in: 1.hour) do
          "second value"
        end
      end

      worker = SmartCache.processor.new
      worker.perform("asdf", "worker value", 24.hours)

      result = @smart_cache.fetch("asdf", expires_in: 1.hour) do
        "ignored value"
      end

      expect(SmartCache.processor).to be_processed_in :smart_cache
      expect(SmartCache.processor).to have(1).jobs

      result.should == "worker value"

    end

  end

end