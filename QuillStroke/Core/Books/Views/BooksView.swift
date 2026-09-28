//
//  BooksView.swift
//  QuillStroke
//
//  Created by Saverio Negro on 9/28/26.
//

import SwiftUI

struct BooksView: View {

    @StateObject private var viewModel = BooksViewModel(service: BookNetworkService())
    
    var body: some View {
        ZStack {
            NavigationStack {
                List {
                    Text("Your Books")
                        .font(.largeTitle)
                        .foregroundStyle(.colorSet.text)
                        .listRowBackground(Color.colorSet.background)
                    ForEach(viewModel.books) { book in
                        BookRow(book: book)
                            .listRowBackground(Color.colorSet.background)
                            .swipeActions(edge: .trailing) {
                                Button(
                                    role: .destructive,
                                    action: {
                                        Task { await viewModel.deleteBook(book) }
                                    },
                                    label: {
                                        Label("Delete", systemImage: "trash")
                                    }
                                )
                            }
                            .onAppear {
                                // Trigger pagination when the last item appears
                                if book.id == viewModel.books.last?.id {
                                    Task { await viewModel.loadMoreBooks() }
                                }
                            }
                    }
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                .listStyle(.plain)
                .scrollContentBackground(.hidden)
                .background(Color.colorSet.background.ignoresSafeArea())
                .searchable(text: $viewModel.searchText, prompt: "Search your book")
                .onChange(of: viewModel.searchText) { _, newValue in
                    // Debounce the search so we don't hit the API on every single keystroke
                    Task {
                        try? await Task.sleep(nanoseconds: 500_000_000) // 0.5s debounce
                        await viewModel.performSearch()
                    }
                }
                .toolbar {
                    Button {
                        // Trigger a create modal
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

#Preview {
    BooksView()
}

