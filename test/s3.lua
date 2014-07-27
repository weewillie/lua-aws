

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
    print("key=" .. k)
    formatting = string.rep("  ", indent) .. k .. ": "
    if type(v) == "table" then
      print(formatting)
      tprint(v, indent+1)
    elseif type(v) == 'boolean' then
      print(formatting .. tostring(v))
    else
      print(formatting .. v)
    end
  end
end


local AWS = require ('lua-aws.init')
AWS = AWS.new({
  endpoint         = 'amazonaws.com',
	accessKeyId      = os.getenv('AWS_ACCESS_KEY'),
	secretAccessKey  = os.getenv('AWS_SECRET_KEY')
})


local res,err = AWS.S3:api():listBuckets()

if res then
    tprint(res, 2)
else
	assert(false, 'error:' .. err)
end
