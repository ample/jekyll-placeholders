require 'spec_helper'

describe Jekyll::Placeholders::Collections do

  before do
    @base = File.expand_path('./spec/dummy')
    @site = JekyllHelper.scaffold(base_path: @base, collections: %w(podcasts episodes))
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

  it 'should return all symbols from a template' do
    tpl = @collections.send(:get_template, 'episodes')
    tokens = @collections.send(:get_symbols, tpl)
    expect(tokens).to match_array(%w(:podcast_slug :slug))
  end

  it 'should return key/values for any tokens defined in a template' do
    tpl = @collections.send(:get_template, 'episodes')
    tokens = @collections.send(:get_symbols, tpl)
    doc = @site.collections['podcasts'].docs.first
    doc.data['podcast_slug'] = 'something'
    placeholders = @collections.send(:get_placeholders, tokens, doc)

    expect(placeholders.dig(:slug)).to eq('testing')
    expect(placeholders.dig(:podcast_slug)).to eq('something')
  end

  it 'should return nested URLs based on placeholder values' do
    doc = @site.collections['episodes'].docs.first
    @collections.send(:set_url!, doc, 'episodes')
    expect(doc.url).to eq("/podcasts/testing/episode-one")
  end

  it 'should return deeply nested URLs based on placeholder values' do
    @site.config['collections']['episodes']['permalink'] = '/podcasts/(:deeply/:nested/:categories/:0/:slug)/:slug'
    doc = @site.collections['episodes'].docs.first
    @collections.send(:set_url!, doc, 'episodes')
    expect(doc.url).to eq("/podcasts/nesting-is-fun/episode-one")
  end

end