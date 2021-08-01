require_relative '../../models/order'

describe Order do
  describe '#valid' do
    it 'should return true for valid data' do
      order = Order.new({
        reference_no: '123',
        customer_name: 'Elda Suryani',
        date: '2021-05-07'})

        expect(order.valid?).to eq(true)
    end
  end

  describe '#save' do
    context 'when entered data valid' do
      it 'should add new order to database' do
        order = Order.new(
        reference_no: '123',
        customer_name: 'Elda Suryani',
        date: '2021-05-07')

        dummy_db = double
        allow(Mysql2::Client).to receive(:new).and_return(dummy_db)
        expect(dummy_db).to receive(:query).with("insert into orders(reference_no, customer_name, date) values ('#{order.reference_no}', '#{order.customer_name}', '#{order.date}')")

        order.save
      end
    end
  end
end
