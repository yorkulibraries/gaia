require 'test_helper'

class AttachmentTest < ActiveSupport::TestCase
  
  should "create a valid attachment" do
        
      attachment = build(:attachment) 
        
      assert attachment.valid?, "Attachment should be valid"
      assert_difference  "Attachment.count", 1 do
        attachment.save
      end
  end
    
  should "Not create an invalid attachment" do

    attachment = build(:attachment, file: nil, name: nil)

    assert !attachment.valid?

    attachment.name = "some name"
    assert !attachment.valid?

    assert_no_difference "Attachment.count" do
      attachment.save
    end      

  end
  
  should "Delete an attachment" do
    
    data_request = create(:data_request)
    attachment = create(:attachment, data_request_id: data_request.id) 

    assert_difference  "Attachment.count", -1 do
      attachment.delete
    end
  end
  
  should "set name to filename if name is blank" do
    attachment = build(:attachment, name: nil)
    
    assert attachment.save
    
    assert_equal "Test Pdf", attachment.name
    
    attachment = build(:attachment, name: "")
    
    assert attachment.save
    
    assert_equal "Test Pdf", attachment.name, "blank name"
  end
  
end
