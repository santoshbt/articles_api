require 'rails_helper'

RSpec.describe "/articles", type: :request do
    describe '#index' do
        it 'returns a success response' do
            get '/articles'
            expect(response.status).to eq(200)
            expect(response).to have_http_status(:ok)
        end

        it 'returns a proper JSON' do
            article = create :article
            get '/articles'
            expect(json_data.length).to eq(1)
            expected = json_data.first
            aggregate_failures do
                expect(expected[:id]).to eq(article.id.to_s)
                expect(expected[:type]).to eq('article')
                expect(expected[:attributes]).to eq(
                    title: article.title,
                    content: article.content,
                    slug: article.slug
                )
            end
        end

        it 'returns the articles to be in the proper order' do
            recent_article = create(:article)
            older_article = 
                create(:article, created_at: 1.hour.ago, slug: 'new-article')
            get '/articles'
            ids = json_data.map {|item| item[:id].to_i}
            expect(ids).to eq([recent_article.id, older_article.id])
        end

        it 'paginates results' do
            article1, article2, article3 = create_list(:article, 3)
            get '/articles', params: {page: {number: 2, size: 1}}
            expect(json_data.length).to eq(1)
            expect(json_data.first[:id]).to eq(article2.id.to_s)
        end

        it 'paginates results' do
            article1, article2, article3 = create_list(:article, 3)
            get '/articles', params: {page: {number: 2, size: 1}}
            expect(json[:links].length).to eq(5)
            expect(json[:links].keys).to contain_exactly(:first, :prev, :next, :last, :self)
        end
    end

    describe '#show' do
        let(:article) {create :article}
        subject {get "/articles/#{article.id}"}

        before {subject}

        it 'returns a success response' do
            expect(response).to have_http_status(:ok)
            expect(response.status).to eq(200)
        end

        it 'returns a proper JSON' do
            expected = json_data
            aggregate_failures do
                expect(expected[:id]).to eq(article.id.to_s)
                expect(expected[:type]).to eq('article')
                expect(expected[:attributes]).to eq(
                    title: article.title,
                    content: article.content,
                    slug: article.slug
                )
            end
        end
    end 
end
