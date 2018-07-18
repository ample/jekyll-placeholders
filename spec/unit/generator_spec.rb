require 'spec_helper'

describe Jekyll::Placeholders::Generator do

  before do
    @site = JekyllHelper.scaffold(
      base_path: File.expand_path('../../../../../spec/source', __dir__),
      collections_dir: File.expand_path('../../../../../spec/source/collections', __dir__),
      collections: %w(podcasts episodes)
    )
    @generator = Jekyll::Placeholders::Generator.new
  end

  it 'should generate URLs with dynamic placeholders' do
    @site.config['collections']['podcasts']['permalink'] = '/podcasts/:test_slug/:slug'
    @site.collections['podcasts'].first.data['test_slug'] = 'testing'
    @generator.generate(@site)

    entry = @site.collections['podcasts'].first
    expect(entry.url).to eq("/podcasts/testing/#{entry.data.dig('slug')}")
  end

end