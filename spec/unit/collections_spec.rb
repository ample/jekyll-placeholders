require 'spec_helper'

describe Jekyll::Placeholders::Collections do

  before do
    @base = File.expand_path('./spec/dummy')
    @site = JekyllHelper.scaffold(base_path: @base, collections: %w(podcasts))
    @collections = Jekyll::Placeholders::Collections.new(@site)
  end

  it 'should parse string and return any symbols' do
    expect(@collections.send(:get_symbols, '/some/:string/with/:symbols')).to eq([':string', ':symbols'])
  end

  it 'should return permalink template for a collection' do
    path = '/ever/thus/to/deadbeats'
    @site.config['collections']['podcasts']['permalink'] = path
    expect(@collections.send(:get_template, 'podcasts')).to eq(path)
  end

  it 'should return all placeholders' do
    pending
    # tpl = @collections.send(:get_template, 'podcasts')
    # tokens = @collections.send(:get_symbols, tpl)
    raise
  end

end