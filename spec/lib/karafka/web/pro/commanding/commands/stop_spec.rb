# frozen_string_literal: true

RSpec.describe_current do
  subject(:stop_command) { described_class.new }

  before { allow(Process).to receive(:kill) }

  it 'expect to send a QUIT signal to the current process' do
    stop_command.call

    expect(Process).to have_received(:kill).with('QUIT', Process.pid)
  end

  context 'when process to which we send request is an embedded one' do
    before { allow(Karafka::Process).to receive(:tags).and_return(%w[embedded]) }

    it 'expect to ignore quiet command in an embedded one' do
      stop_command.call

      expect(Process).not_to have_received(:kill)
    end
  end
end
