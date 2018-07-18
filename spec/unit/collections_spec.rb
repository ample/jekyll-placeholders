require 'spec_helper'

describe Jekyll::Placeholders::Collections do

  before do
    @base = FileUtils.pwd
    @site = JekyllHelper.scaffold
    @collections = Jekyll::Placeholders::Collections.new(@site)
  end

  it 'should parse string and return any symbols' do
    expect(@collections.send(:get_symbols, '/some/:string/with/:symbols')).to eq(['string', 'symbols'])
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