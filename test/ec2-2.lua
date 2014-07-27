

-- Print contents of `tbl`, with indentation.
-- `indent` sets the initial level of indentation.
function tprint (tbl, indent)
  if not indent then indent = 0 end
  for k, v in pairs(tbl) do
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
    endpoint = 'us-east-1.amazonaws.com',
	accessKeyId = os.getenv('AWS_ACCESS_KEY'),
	secretAccessKey = os.getenv('AWS_SECRET_KEY')
})

local res,err = AWS.EC2:api():describeInstances()

if res then
    tprint(res, 2)
	--local serpent = require ('serpent')
	--print(serpent.dump(res, { compact = false }))
	--dump(res)
	-- assert(res.value.DescribeInstancesResponse.xarg.xmlns == "http://ec2.amazonaws.com/doc/2013-02-01/")
	-- assert(res.value.DescribeInstancesResponse.value.reservationSet.value.item[1].value.ownerId.value == '871570535967')
else
	assert(false, 'error:' .. err)
end
